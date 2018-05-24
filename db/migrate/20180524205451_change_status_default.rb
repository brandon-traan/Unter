class ChangeStatusDefault < ActiveRecord::Migration[5.1]
  def change
    rename_column :bookings, :Status, :status
    change_column :bookings, :status, :string, :default => "Awaiting"
  end
end
