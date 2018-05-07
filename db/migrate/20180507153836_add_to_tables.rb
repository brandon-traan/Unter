class AddToTables < ActiveRecord::Migration[5.1]
  def change
     add_column :users, :role , :string, default: "Customer"
     add_column :users, :rentalCharge, :float , default: 0.0
     add_column :cars, :location, :string
     add_column :cars, :status, :string
     
     
     
  end
end
