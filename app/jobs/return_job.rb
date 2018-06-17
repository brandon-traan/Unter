class ReturnJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    booking_id = args[0]
    booking = Booking.find(booking_id)
    if booking.status == "Active"
      booking.update_attribute(:returnT, Time.now)
      booking.update_attribute(:status, "Complete")
      car = Car.find(booking.car_id)
      user = User.find(booking.user_id)
      notice = "You are late to return the car"
      car.update_attribute(:status, "Available")
      user.update_attribute(:available, true)
      user.update_attribute(:notification, notice)
      
      # send email notification if someone is waiting
      Waitinglist.where({car_id: car.id, status: "Awaiting"}).find_each do |wait|
        UserMailer.car_available(User.find(wait.user_id), Car.find(wait.car_id)).deliver
        wait.update_attribute(:status, "Complete")
      end
      
      # calculate charge
      price = car.hourlyRentalRate
      hold_time = (booking.returnT - booking.pickUpT)/3600.0 # convert to hours
      charge = user.price + price*hold_time
      user.update_attribute(:price, charge) 
      # user.update_attribute(:notification, "You have pending charge!")
      
    end
  end
end