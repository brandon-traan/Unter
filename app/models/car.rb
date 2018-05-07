class Car < ApplicationRecord
  has_many :bookings
  has_many :users, through: :bookings
  
  validates :make, presence: true
  validates :model, presence: true
  validates :year, presence: true
  validates :size, presence: true
  validates :price, presence: true
end
