class AddReturnt < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :returnT, :datetime
  end
end
