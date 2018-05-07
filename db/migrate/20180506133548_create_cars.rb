class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :make
      t.string :model
      t.string :year
      t.string :size
      t.string :price

      t.timestamps
      
      end
      create_table :booking do |t|
        t.belongs_to :users, index: true
        t.belongs_to :cars, indext: true
        t.integer :user_id
        t.string  :user_firstname
        t.timestamps
      end
  end
end
