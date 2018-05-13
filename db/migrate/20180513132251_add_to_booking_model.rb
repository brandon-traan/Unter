class AddToBookingModel < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :expectedReturn, :timestamp
    add_column :bookings, :Status, :string, default: "Awaiting"
  end
end
