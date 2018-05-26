class WelcomeController < ApplicationController
  def hello
    @cars = Car.all
    gon.cars = Car.all
  end

end
