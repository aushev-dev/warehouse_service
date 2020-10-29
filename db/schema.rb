# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_25_114759) do

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.integer "count"
    t.integer "price"
    t.integer "warehouse_id", null: false
    t.boolean "sold", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["count"], name: "index_products_on_count"
    t.index ["warehouse_id"], name: "index_products_on_warehouse_id"
  end

  create_table "warehouses", force: :cascade do |t|
    t.string "name", null: false
    t.text "address", null: false
    t.integer "balance", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
