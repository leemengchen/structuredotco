class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :description
      t.string :image
      t.integer :item_id

      t.timestamps
    end
  end
end
