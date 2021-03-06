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

ActiveRecord::Schema.define(version: 2021_06_04_032753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "region"
    t.string "zone"
    t.string "woreda"
    t.string "kebele"
    t.string "block_number"
    t.string "house_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "due_balances", force: :cascade do |t|
    t.float "balance"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_due_balances_on_user_id"
  end

  create_table "energy_meters", force: :cascade do |t|
    t.float "power"
    t.float "power_factor"
    t.date "date"
    t.time "time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_energy_meters_on_user_id"
  end

  create_table "role_types", force: :cascade do |t|
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "phone_number"
    t.string "email"
    t.bigint "address_id", null: false
    t.date "connection_date"
    t.bigint "role_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "username"
    t.index ["address_id"], name: "index_users_on_address_id"
    t.index ["role_type_id"], name: "index_users_on_role_type_id"
  end

  add_foreign_key "due_balances", "users"
  add_foreign_key "energy_meters", "users"
  add_foreign_key "users", "addresses"
  add_foreign_key "users", "role_types"
end
