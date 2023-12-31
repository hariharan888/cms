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

ActiveRecord::Schema[7.0].define(version: 2023_08_20_115626) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "stock_codes", force: :cascade do |t|
    t.integer "code_type", null: false
    t.string "value", null: false
    t.bigint "stock_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["code_type", "value"], name: "index_stock_codes_on_code_type_and_value", unique: true
    t.index ["discarded_at"], name: "index_stock_codes_on_discarded_at"
    t.index ["stock_id", "code_type"], name: "index_stock_codes_on_stock_id_and_code_type", unique: true
    t.index ["stock_id"], name: "index_stock_codes_on_stock_id"
  end

  create_table "stock_group_junctions", force: :cascade do |t|
    t.bigint "stock_id", null: false
    t.bigint "stock_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_stock_group_junctions_on_discarded_at"
    t.index ["stock_group_id"], name: "index_stock_group_junctions_on_stock_group_id"
    t.index ["stock_id", "stock_group_id"], name: "index_stock_group_junctions_on_stock_id_and_stock_group_id", unique: true
    t.index ["stock_id"], name: "index_stock_group_junctions_on_stock_id"
  end

  create_table "stock_groups", force: :cascade do |t|
    t.string "name"
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_stock_groups_on_discarded_at"
  end

  create_table "stock_values", force: :cascade do |t|
    t.bigint "stock_id", null: false
    t.float "open", null: false
    t.float "close", null: false
    t.float "high", null: false
    t.float "low", null: false
    t.integer "volume", null: false
    t.datetime "time", null: false
    t.integer "resolution", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_stock_values_on_discarded_at"
    t.index ["stock_id", "time", "resolution"], name: "index_stock_values_on_stock_id_and_time_and_resolution", unique: true
    t.index ["stock_id"], name: "index_stock_values_on_stock_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_stocks_on_discarded_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "jti", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "stock_codes", "stocks"
  add_foreign_key "stock_group_junctions", "stock_groups"
  add_foreign_key "stock_group_junctions", "stocks"
  add_foreign_key "stock_values", "stocks"
end
