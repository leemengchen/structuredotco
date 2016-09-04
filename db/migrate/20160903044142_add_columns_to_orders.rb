class AddColumnsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :user_id, :integer
    add_column :orders, :total_price, :decimal
  end
end
