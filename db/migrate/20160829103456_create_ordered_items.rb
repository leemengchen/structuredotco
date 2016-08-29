class CreateOrderedItems < ActiveRecord::Migration[5.0]
  def change
    create_table :ordered_items do |t|
      t.integer :quantity
      t.integer :order_id
      t.integer :item_id

      t.timestamps
    end
  end
end
