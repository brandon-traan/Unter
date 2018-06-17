class FixBookingTable < ActiveRecord::Migration[5.1]
  def change
    rename_column :bookings, :users_firstname, :user_firstname
  end
end
