class AddLatitudeLongitude < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :longitude, :float
    add_column :bookings, :latitude, :float
  end
end
