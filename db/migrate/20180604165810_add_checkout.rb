class AddCheckout < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :checkOut, :datetime, default: "" ,:null => false
  end
end
