class ChangePriceDataTypeInItems < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :price, :decimal
  end
end
