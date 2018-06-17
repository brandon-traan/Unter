class PickupTrue < ActiveRecord::Migration[5.1]
  def change
    change_column :bookings, :pickup, :datetime, :null => true
  end
end
