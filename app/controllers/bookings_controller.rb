class BookingsController < ApplicationController
  def new
    @booking = Booking.new
  end
  def booking_params
    params.require(:booking).permit(:users_id, :cars_id, :user_firstname, :user_lastname,
                                        :user_email, :user_phone, :user_phone, :car_make,
                                        :car_model, :car_year, :car_size, :car_price)
  end
  def create
    car_id = booking_params[:car_id]
    user_id = booking_params[:user_id]
    if user_id==""
      flash[:danger] = "You should select a user."
      redirect_to new_booking_path(:car_id => car_id)
      return
    end
    user = User.find(user_id)
  end
end
