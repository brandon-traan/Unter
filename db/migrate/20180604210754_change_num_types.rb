class ChangeNumTypes < ActiveRecord::Migration[5.1]
  def change
    change_column :cars, :year, :integer
    change_column :cars, :price, :integer
  end
end
