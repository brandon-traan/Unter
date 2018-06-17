class DropReturn < ActiveRecord::Migration[5.1]
  def change
    remove_column :bookings, :return, :datetime
  end
end
