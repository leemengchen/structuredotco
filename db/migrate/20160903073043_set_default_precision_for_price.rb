class SetDefaultPrecisionForPrice < ActiveRecord::Migration[5.0]
  def up
    change_column :items, :price, :decimal, precision: 2
  end

  def down
    change_column :items, :price, :decimal
  end
end
