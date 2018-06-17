class ChangeIdColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :bookings, :cars_id, :car_id
    rename_column :bookings, :users_id
  end
end
