class Car < ApplicationRecord
  has_many :bookings
  has_many :users, through: :bookings
  
  enum sizes: [:Small, :Medium, :Big]
  enum statuses: [:CheckedOut, :Available, :Reserved, :Suggested]
  
  validates :make, presence: true
  validates :model, presence: true
  validates :year, presence: true
  validates :size, presence: true
  validates :price, presence: true
end
