class AddNullToColumn < ActiveRecord::Migration[5.1]
  def change
     change_column :bookings, :expectedReturn, :timestamp, null: false
  end
end
