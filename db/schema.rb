# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_11_07_155749) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dental_items", force: :cascade do |t|
    t.string "item_code"
    t.string "item_name"
    t.string "item_url"
    t.string "item_image_urls"
    t.integer "genre_id"
    t.bigint "user_id"
    t.bigint "toothbrush_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["toothbrush_id"], name: "index_dental_items_on_toothbrush_id"
    t.index ["user_id"], name: "index_dental_items_on_user_id"
  end

  create_table "toothbrushes", force: :cascade do |t|
    t.string "item_code"
    t.string "item_name"
    t.string "item_url"
    t.string "item_image_urls"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state", default: 0, null: false
    t.integer "brush_material", default: 0, null: false
    t.integer "hardness", default: 0, null: false
    t.datetime "end_use_at"
    t.index ["user_id"], name: "index_toothbrushes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "line_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.string "name", default: "ゲスト", null: false
    t.index ["line_user_id"], name: "index_users_on_line_user_id", unique: true
  end

  add_foreign_key "dental_items", "toothbrushes"
  add_foreign_key "dental_items", "users"
  add_foreign_key "toothbrushes", "users"
end
