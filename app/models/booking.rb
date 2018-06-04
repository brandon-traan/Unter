class Booking < ApplicationRecord
  require 'date'
  enum statuses: [:Awaiting, :Active, :Complete, :Cancel]
  validates :status, inclusion: {in: statuses}
  validates :expectedReturn, presence: true
  validates :checkOut, presence: true
  validate :orderTimeValidation
  
  def orderTimeValidation 
    if checkOut < Time.now - 5.minutes || checkOut > Time.now + 7.days
      errors.add(:checkOut, "should within 7 days from now!")
    elsif expectedReturn < Time.now || expectedReturn > Time.now + 7.days
      errors.add(:expectedReturn, "should within 7 days from now!")
    elsif (expectedReturn - checkOut) < 1.hour || (expectedReturn - checkOut) > 10.hours
      errors.add(:expectedReturn, "should be within 1-10 hours of checkout time!")
    end 
  end
  
end
