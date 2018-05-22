class AddTrueToStatus < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :available, :boolean, default: true
  end
end
