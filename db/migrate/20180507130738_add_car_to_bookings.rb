class AddCarToBookings < ActiveRecord::Migration[5.1]
  def change
    add_reference :bookings, :car, foreign_key: true
  end
end
