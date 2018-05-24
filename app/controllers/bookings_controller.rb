class BookingsController < ApplicationController
  include BookingsHelper
  
  require "date"
  Time.zone = "Australia/Melbourne"
  
  before_action :logged_in_user, only: [:show, :edit, :index, :new, :create, :pickup, :returnT, :cancel, :destroy]
  
  
  
  def index
    @q_bookings = Booking.ransack(params[:q])
    @bookings = @q_bookings.result().where(:user_id => session[:user_id]).paginate(page: params[:page]) || [] # return current users record or empty
  end
  
  def show
    @booking = Booking.find(params[:id])
  end
  
  def new
    @booking = Booking.new
  end
  
  def create
    car_id = booking_params[:car_id]
    user_id = booking_params[:user_id]
    user = User.find_by(user_id)
    if user.available
      @booking = Booking.new(booking_params)
      if @booking.save
        flash[:success] = 'Booking was successfully created.'
        PickupJob.set(wait_until: @booking.pickup + 30.minutes).perform_later(@booking.id)
        redirect_to @booking
        cars = Car.find_by(@booking.car_id)
        cars.update_attribute(:status, "Reserved")
        user.update_attribute(:available, false)
      else
        if @booking.errors.any?
          @booking.errors.full_messages.each do |message|
            flash[:errors] = message
          end
        end
        redirect_to new_booking_path(:car_id => car_id)
      end
    else
      flash[:danger] = "This users have a cars in hold, and cannot reserve another cars until you return it."
      redirect_to users
    end
  end
  
  def pickup
    @booking = Booking.find_by(params[:id])
    if @booking.pickup > Time.now
      flash[:error] = 'You need to wait to pick up the cars!'
      redirect_to @booking
    elsif @booking.update_attribute(:pickup, Time.now)
      flash[:success] = 'Car was successfully picked up. Have a good time!'
      @booking.update_attribute(:status, "Active")
      cars = Car.find_by(@booking.car_model)
      cars.update_attribute(:status, "CheckedOut")
      ReturnCheckJob.set(wait_until: @booking.expectedReturn + 60).perform_later(@booking.id)
      redirect_to @booking
    end
  end

  def returncars
    @booking = Booking.find_by(params[:id])
    if @booking.update_attribute(:returnT, Time.now)
      flash[:success] = 'Car was successfully returned. Thank you!'
      @booking.update_attribute(:status, "Complete")
      users = User.find_by(@booking.user_id)
      cars = Car.find_by(@booking.car_id)
      cars.update_attribute(:status, "Available")
      
      price = cars.hourlyRentalRate
      hold_time = (@booking.returnT - @booking.pickup)/3600.0 # convert to hours
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
    if @booking.update_attribute(:returnT, Time.now)
      flash[:success] = 'Car returned'
      @booking.update_attribute(:status, "Complete")
      user = User.find_by(@booking.user_id)
      car = Car.find_by(@booking.car_id)
      car.update_attribute(:status, "Available")
      
      # send email notification if someone is waiting
      Waitinglist.where({car_id: car.id, status: "Awaiting"}).find_each do |wait|
        UserMailer.car_available(User.find(wait.user_id), Car.find(wait.car_id)).deliver
        wait.update_attribute(:status, "Complete")
      end
      
      # calculate charge
      price = car.hourlyRentalRate
      hold_time = (@booking.returnT - @booking.pickup)/3600.0 # convert to hours
      charge = user.rentalCharge + price*hold_time
      user.update_attribute(:rentalCharge, charge) 
      user.update_attribute(:available, true)
      redirect_to @booking
    end
  end

  def cancel
    @booking = Booking.find_by(params[:id])
    if ["Active", "Complete", "Cancel"].include? @booking.status
      flash[:danger] = "Booking cannot be canceled!"
      redirect_to @booking
      return
    end
    if @booking.update_attribute(:status, "Cancel")
      User.find(@booking.user_id).update_attribute(:available, true)
      Car.find(@booking.car_id).update_attribute(:status, "Available")
      
      # send email notification if someone is waiting
      car = Car.find_by(@booking.car_id)
      Waitinglist.where({car_id: car.id, status: "Awaiting"}).find_each do |wait|
        UserMailer.car_available(User.find(wait.user_id), Car.find(wait.car_id)).deliver
        wait.update_attribute(:status, "Complete")
      end
      
      flash[:success] = "Booking canceled!"
      redirect_to @booking
    end
  end
  private
  def booking_params
    params.require(:booking).permit(:user_id, :car_id, :pickup, 
                                    :expectedReturn, :status, :returnT)
  end
  
end
