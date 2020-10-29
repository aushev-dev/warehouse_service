class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :count
      t.integer :price
      t.integer :warehouse_id, null: false
      t.boolean :sold, default: false

      t.timestamps
    end
    add_index :products, :warehouse_id
    add_index :products, :count

  end
end
