class Booking < ApplicationRecord
  require 'date'
  enum statuses: [:Awaiting, :Active, :Complete, :Cancel]
  validates :status, inclusion: {in: statuses}
  validates :pickup, presence: true
  validates :expectedReturn, presence: true
  
end
