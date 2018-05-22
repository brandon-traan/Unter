class BookingsController < ApplicationController
  include BookingsHelper
  
  require "date"
  Time.zone = "Australia/Melbourne"
  
  before_action :logged_in_user, only: [:show, :edit, :index, :new, :create, :pickup, :return, :cancel, :destroy]
  
  def booking_params
    params.require(:booking).permit(:users_id, :cars_id, :users_firstname, :users_lastname,
                                        :users_email, :users_phone, :users_phone, :cars_make,
                                        :cars_model, :cars_year, :cars_size, :cars_price, :pickup, 
                                        :return)
  end
  
  def index
    @q_bookings = Booking.ransack(params[:q])
    @bookings = @q_bookings.result().where(:users_id => session[:users_id]).paginate(page: params[:page]) || [] # return current users record or empty
  end
  
  def new
    @booking = Booking.new
  end
  
  def show
    @booking = Booking.find(params[:id])
  end
  
  def create
    cars_id = booking_params[:cars_id]
    users_id = booking_params[:users_id]
    if users_id==""
      flash[:danger] = "Select a user."
      redirect_to new_booking_path(:cars_id => cars_id)
      return
    end
    unless Car.find_by(cars_id).status == "Available"
      flash[:danger] = "Not available."
      redirect_to cars_path
      return
    end
    users = User.find_by(users_id)
    if users.available
      @booking = Booking.new(booking_params)
      if @booking.save
        flash[:success] = 'Booking was successfully created.'
        # UserMailer.welcome_email(users).deliver
        PickupCheckJob.set(wait_until: @booking.checkOutTime + 30.minutes).perform_later(@booking.id)
        redirect_to @booking
        cars = Car.find_by(@booking.cars_id)
        cars.update_attribute(:status, "Reserved")
        users.update_attribute(:available, false)
      else
        if @booking.errors.any?
          @booking.errors.full_messages.each do |message|
            flash[:errors] = message
          end
        end
        redirect_to new_booking_path(:cars_id => cars_id)
      end
    else
      flash[:danger] = "This users have a cars in hold, and cannot reserve another cars until you return it."
      redirect_to users
    end
  end
  
  def pickup
    @booking = Booking.find_by(params[:id])
    if @booking.checkOutTime > Time.now
      flash[:error] = 'You need to wait to pick up the cars!'
      redirect_to @booking
    elsif @booking.update_attribute(:pickUpTime, Time.now)
      flash[:success] = 'Car was successfully picked up. Have a good time!'
      @booking.update_attribute(:bookingStatus, "Active")
      cars = Car.find_by(@booking.cars_id)
      cars.update_attribute(:status, "CheckedOut")
      ReturnCheckJob.set(wait_until: @booking.expectedReturnTime + 60).perform_later(@booking.id)
      redirect_to @booking
    end
  end

  def returncars
    @booking = Booking.find_by(params[:id])
    if @booking.update_attribute(:returnTime, Time.now)
      flash[:success] = 'Car was successfully returned. Thank you!'
      @booking.update_attribute(:bookingStatus, "Complete")
      users = User.find_by(@booking.users_id)
      cars = Car.find_by(@booking.cars_id)
      cars.update_attribute(:status, "Available")
      
      price = cars.hourlyRentalRate
      hold_time = (@booking.returnTime - @booking.pickUpTime)/3600.0 # convert to hours
      charge = users.rentalCharge + price*hold_time
      users.update_attribute(:rentalCharge, charge) 
      users.update_attribute(:notification, "You can reserve a cars now!")
      users.update_attribute(:available, true)
      redirect_to @booking
    end
  end
  
  def update
    @booking = Booking.find_by(params[:id])
    if @booking.update(booking_params)
      flash[:success] = 'Booking updated.'
      redirect_to @booking
    else
      render :edit
    end
  end
  
  def returncar
    @booking = Booking.find_by(params[:id])
    if @booking.update_attribute(:returnTime, Time.now)
      flash[:success] = 'Car returned'
      @booking.update_attribute(:bookingStatus, "Complete")
      user = User.find_by(@booking.user_id)
      car = Car.find_by(@booking.cars_id)
      car.update_attribute(:status, "Available")
      
      # send email notification if someone is waiting
      Waitinglist.where({cars_id: car.id, status: "Awaiting"}).find_each do |wait|
        UserMailer.car_available(User.find(wait.user_id), Car.find(wait.cars_id)).deliver
        wait.update_attribute(:status, "Complete")
      end
      
      # calculate charge
      price = car.hourlyRentalRate
      hold_time = (@booking.returnTime - @booking.pickUpTime)/3600.0 # convert to hours
      charge = user.rentalCharge + price*hold_time
      user.update_attribute(:rentalCharge, charge) 
      user.update_attribute(:notification, "You can reserve a car now!")
      user.update_attribute(:available, true)
      redirect_to @booking
    end
  end

  def cancel
    @booking = Booking.find_by(params[:id])
    if ["Active", "Complete", "Cancel"].include? @booking.bookingStatus
      flash[:danger] = "Booking cannot be canceled!"
      redirect_to @booking
      return
    end
    if @booking.update_attribute(:bookingStatus, "Cancel")
      User.find(@booking.user_id).update_attribute(:available, true)
      Car.find(@booking.cars_id).update_attribute(:status, "Available")
      
      # send email notification if someone is waiting
      car = Car.find_by(@booking.cars_id)
      Waitinglist.where({cars_id: car.id, status: "Awaiting"}).find_each do |wait|
        UserMailer.car_available(User.find(wait.user_id), Car.find(wait.cars_id)).deliver
        wait.update_attribute(:status, "Complete")
      end
      
      flash[:success] = "Booking canceled!"
      redirect_to @booking
    end
  end
  
end
