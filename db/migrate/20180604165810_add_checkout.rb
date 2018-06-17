class AddCheckout < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :checkOut, :datetime, 'USING CAST(case when datetime = '' then null else datetime end AS date)'
  end
end
