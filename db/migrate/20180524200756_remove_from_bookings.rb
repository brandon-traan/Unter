class RemoveFromBookings < ActiveRecord::Migration[5.1]
  def change
    remove_column :bookings, :user_firstname
    remove_column :bookings, :user_lastname
    remove_column :bookings, :user_email
    remove_column :bookings, :user_phone
    remove_column :bookings, :car_make
    remove_column :bookings, :car_model
    remove_column :bookings, :car_year
    remove_column :bookings, :car_size
    remove_column :bookings, :car_price
  end
end
