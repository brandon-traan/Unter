class ChangePriceType < ActiveRecord::Migration[5.1]
  def change
    change_column :cars, :price, USING price::double precision
    change_column :bookings, :car_price, USING price::double precision
  end
end
