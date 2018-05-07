class AddToBookingTimestamps < ActiveRecord::Migration[5.1]
  def change
    change_column :booking, :pickup, :timestamp, null: false
    change_column :booking, :return, :timestamp, null: false
  end
end
