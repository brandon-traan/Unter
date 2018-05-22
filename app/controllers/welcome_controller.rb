class WelcomeController < ApplicationController
  def hello
    @cars = Car.all
  end

end
