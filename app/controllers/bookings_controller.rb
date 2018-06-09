class BookingsController < ApplicationController
  include BookingsHelper
  
  require "date"
  Time.zone = "Australia/Melbourne"
  
  before_action :logged_in_user, only: [:show, :edit, :index, :new, :create, :pickup, :returncar, :cancel, :destroy]
  before_action :logged_in_as_admin, only: [:destroy]
  before_action :can_destroy, only: [:destroy]
  
  def index
     if isAdmin? || isSuperAdmin?
      @q_bookings = Booking.ransack(params[:q])
      @bookings = @q_bookings.result().paginate(page: params[:page])
    else
      @bookings = Booking.where(:user_id => session[:user_id]) || [] 
     end
  end
  
  def show
    @booking = Booking.find(params[:id])
  end
  
  def new
    @booking = Booking.new
  end
  def edit
    @booking = Booking.find(params[:id])
  end
  
  def create
    car_id = booking_params[:car_id]
    user_id = booking_params[:user_id]
    if user_id==""
      flash[:danger] = "You should select a user."
      redirect_to new_booking_path(:car_id => car_id)
      return
    end
    unless Car.find(car_id).status == "Available"
      flash[:danger] = "This car is not available."
      redirect_to cars_path
      return
    end
    user = User.find(user_id)
    if user.available
      @booking = Booking.new(booking_params)
      if @booking.save
        flash[:success] = 'Booking was successfully created.'
        PickupJob.set(wait_until: @booking.checkOut + 30.minutes).perform_later(@booking.id)
        redirect_to @booking
        cars = Car.find(@booking.car_id.to_s)
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
      redirect_to user
    end
  end
  
  def pickup
    @booking = Booking.find(params[:id])
    if @booking.checkOut && (@booking.checkOut > Time.now)
      flash[:error] = 'You need to wait to pick up the cars!'
      redirect_to @booking
    elsif @booking.update_attribute(:pickup, Time.now)
      flash[:success] = 'Car was successfully picked up. Have a good time!'
      @booking.update_attribute(:status, "Active")
      cars = Car.find(@booking.car_id)
      cars.update_attribute(:status, "CheckedOut")
      ReturnJob.set(wait_until: @booking.expectedReturn + 60).perform_later(@booking.id)
      redirect_to @booking
    end
  end

  def returncar
    @booking = Booking.find(params[:id])
    if @booking.update_attribute(:returnT, Time.now)
      flash[:success] = 'Car was successfully returned. Thank you!'
      @booking.update_attribute(:status, "Complete")
      users = User.find(@booking.user_id)
      cars = Car.find(@booking.car_id)
      cars.update_attribute(:status, "Available")
      
      price = cars.price
      hold_time = (@booking.returnT - @booking.pickup)/3600.0 # convert to hours
      charge = users.rentalCharge + price*hold_time
      users.update_attribute(:rentalCharge, charge) 
      users.update_attribute(:available, true)
      redirect_to @booking
    end
  end
  
  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      flash[:success] = 'Booking updated.'
      redirect_to @booking
    else
      render :edit
    end
  end
  
  def destroy
    @booking = Booking.find(params[:id])
    User.find(@booking.user_id).update_attribute(:available, true)
    Car.find(@booking.car_id).update_attribute(:status, "Available")
    @booking.destroy
    flash[:success] = 'Booking deleted!'
    redirect_to bookings_url
  end

  def cancel
    @booking = Booking.find(params[:id])
    if ["Active", "Complete", "Cancel"].include? @booking.status
      flash[:danger] = "Booking cannot be canceled!"
      redirect_to @booking
      return
    end
    if @booking.update_attribute(:status, "Cancel")
      User.find(@booking.user_id).update_attribute(:available, true)
      Car.find(@booking.car_id).update_attribute(:status, "Available")
      
      
      flash[:success] = "Booking canceled!"
      redirect_to @booking
    end
  end
  private
  def booking_params
    params.require(:booking).permit(:user_id, :car_id, :pickup, 
                                    :expectedReturn, :status, :returnT, :checkOut)
  end
  def can_destroy
      @car = Car.find(params[:id])
      booking_in_use = Booking.where(car_id: @car.id)
                                .where.not(status: ['Complete', 'Cancel']).size != 0
      if @car.status != "Available" || booking_in_use
        flash[:danger] = "This car is in use. It cannot be deleted now!"
        redirect_to @car
      end
  end
end
