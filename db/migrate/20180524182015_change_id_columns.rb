class ChangeIdColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :bookings, :cars_id, :car_id
  end
end
