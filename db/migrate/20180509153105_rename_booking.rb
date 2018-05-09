class RenameBooking < ActiveRecord::Migration[5.1]
  def self.up
    rename_table :booking, :bookings
  end
  def self.down
    rename_table :bookings, :booking
  end
end
