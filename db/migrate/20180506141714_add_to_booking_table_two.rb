class AddToBookingTableTwo < ActiveRecord::Migration[5.1]
  def change
    rename_column :booking, :user_firstname, :users_firstname
  end
end
