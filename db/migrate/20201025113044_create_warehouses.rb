class CreateWarehouses < ActiveRecord::Migration[6.0]
  def change
    create_table :warehouses do |t|
      t.string :name, null: false
      t.text :address, null: false
      t.integer :balance, default: 0

      t.timestamps
    end
  end
end
