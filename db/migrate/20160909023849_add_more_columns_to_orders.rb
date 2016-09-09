class AddMoreColumnsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :full_name, :integer
    add_column :orders, :shipping_address, :integer
  end
end
