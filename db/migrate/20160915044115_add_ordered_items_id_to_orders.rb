class AddOrderedItemsIdToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :ordered_items_id, :integer
  end
end
