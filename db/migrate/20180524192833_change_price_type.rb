class ChangePriceType < ActiveRecord::Migration[5.1]
  def change
    change_column :cars, :price, :float
    change_column :bookings, :car_price, :float
  end
end
