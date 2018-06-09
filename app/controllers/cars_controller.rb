class CarsController < ApplicationController
   before_action :logged_in_user, only: [:index, :new, :show]
   before_action :logged_in_as_admin, only: [:new, :destroy, :edit, :update]
  def index
    @q_cars = Car.ransack(params[:q])
    @cars = @q_cars.result().paginate(page: params[:page])
  end
  
  def show
    @car = Car.find(params[:id])
  end
  
  def new
    @car = Car.new
  end
  
  def create
    @car = Car.new(car_params)
    if @car.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @car = Car.find_by(params[:id])
  end
  def destroy
    @car = Car.find_by(params[:id])
    reservations = Reservation.where(car_id: @car.id)
    reservations.destroy_all
    @car.destroy
    flash[:success] = 'Car deleted.'
    redirect_to cars_url
  end
  private

    def car_params
      params.require(:car).permit(:make, :model, :year, :size, :price, :location, :status)
    end
  
end