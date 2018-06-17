class ChangeLatitudeLongitude < ActiveRecord::Migration[5.1]
  def change
    remove_column :bookings, :longitude, :float
    remove_column :bookings, :latitude, :float
    add_column :cars, :longitude, :float
    add_column :cars, :latitude, :float
  end
end
