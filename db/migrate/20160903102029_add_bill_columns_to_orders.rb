class AddBillColumnsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :bill_id, :string
    add_column :orders, :bill_url, :string
    add_column :orders, :status, :integer, default: 0
    add_column :orders, :due_at, :datetime
  end
end
