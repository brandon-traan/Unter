class ChangePriceType < ActiveRecord::Migration[5.1]
  def change
    change_column :cars, :price, 'float USING CAST(price AS double precision)'
    change_column :bookings, :car_price, 'float USING CAST(car_price AS double precision)'
  end
end
