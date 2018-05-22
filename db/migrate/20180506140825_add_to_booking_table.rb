class AddToBookingTable < ActiveRecord::Migration[5.1]
  def change
    add_column :booking, :user_lastname , :string
    add_column :booking, :user_email, :string
    add_column :booking, :user_phone, :string
    add_column :booking, :car_make, :string
    add_column :booking, :car_model, :string
    add_column :booking, :car_year, :string
    add_column :booking, :car_size, :string
    add_column :booking, :car_price, :string
  end
end
