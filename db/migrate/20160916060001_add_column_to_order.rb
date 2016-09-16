class AddColumnToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :address, :text, default: ""
    add_column :orders, :phone, :string, default: ""
  end
end
