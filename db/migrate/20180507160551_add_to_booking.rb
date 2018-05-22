class AddToBooking < ActiveRecord::Migration[5.1]
  def change
    add_column :booking, :pickup, :timestamp
    add_column :booking, :return, :timestamp
  end
end
