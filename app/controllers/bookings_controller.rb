class BookingsController < ApplicationController
  require "date"
  Time.zone = "Australia/Melbourne"
  def new
    @booking = Booking.new
  end
  def booking_params
    params.require(:booking).permit(:users_id, :cars_id, :user_firstname, :user_lastname,
                                        :user_email, :user_phone, :user_phone, :car_make,
                                        :car_model, :car_year, :car_size, :car_price, :pickup, 
                                        :return)
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
        # UserMailer.welcome_email(user).deliver
        PickupCheckJob.set(wait_until: @booking.checkOutTime + 30.minutes).perform_later(@booking.id)
        redirect_to @booking
        car = Car.find(@booking.car_id)
        car.update_attribute(:status, "Reserved")
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
      flash[:danger] = "This user have a car in hold, and cannot reserve another car until you return it."
      redirect_to user
    end
  end
  def pickup
    @booking = Booking.find(params[:id])
    if @booking.checkOutTime > Time.now
      flash[:error] = 'You need to wait to pick up the car!'
      redirect_to @booking
    elsif @booking.update_attribute(:pickUpTime, Time.now)
      flash[:success] = 'Car was successfully picked up. Have a good time!'
      @booking.update_attribute(:bookingStatus, "Active")
      car = Car.find(@booking.car_id)
      car.update_attribute(:status, "CheckedOut")
      ReturnCheckJob.set(wait_until: @booking.expectedReturnTime + 60).perform_later(@booking.id)
      redirect_to @booking
    end
  end

  def returncar
    @booking = Booking.find(params[:id])
    if @booking.update_attribute(:returnTime, Time.now)
      flash[:success] = 'Car was successfully returned. Thank you!'
      @booking.update_attribute(:bookingStatus, "Complete")
      user = User.find(@booking.user_id)
      car = Car.find(@booking.car_id)
      car.update_attribute(:status, "Available")
      
      price = car.hourlyRentalRate
      hold_time = (@booking.returnTime - @booking.pickUpTime)/3600.0 # convert to hours
      charge = user.rentalCharge + price*hold_time
      user.update_attribute(:rentalCharge, charge) 
      user.update_attribute(:notification, "You can reserve a car now!")
      user.update_attribute(:available, true)
      redirect_to @booking
    end
  end
end
