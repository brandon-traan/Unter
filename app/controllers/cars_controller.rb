class CarsController < ApplicationController
  
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
  private

    def car_params
      params.require(:car).permit(:make, :model, :year, :size, :price)
    end
  
end