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

ActiveRecord::Schema[7.0].define(version: 2022_06_15_065901) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deposits", force: :cascade do |t|
    t.decimal "amount", precision: 17, scale: 2, default: "0.0", null: false
    t.bigint "user_id"
    t.bigint "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_deposits_on_stock_id"
    t.index ["user_id"], name: "index_deposits_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "account_number"
    t.string "name"
    t.string "code"
    t.decimal "balance", precision: 17, scale: 2, default: "0.0", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stocks_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "code"
    t.string "transactable_type"
    t.integer "transactable_id"
    t.string "sourceable_type"
    t.integer "sourceable_id"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.decimal "amount", precision: 17, scale: 2, default: "0.0", null: false
    t.string "note"
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_transfers_on_receiver_id"
    t.index ["sender_id"], name: "index_transfers_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "username", default: "", null: false
    t.string "full_name", default: "", null: false
    t.string "phone_number", default: "", null: false
    t.string "account_number", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.decimal "balance", precision: 17, scale: 2, default: "0.0", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_number"], name: "index_users_on_account_number", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "withdraws", force: :cascade do |t|
    t.decimal "amount", precision: 17, scale: 2, default: "0.0", null: false
    t.bigint "user_id"
    t.bigint "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_withdraws_on_stock_id"
    t.index ["user_id"], name: "index_withdraws_on_user_id"
  end

  add_foreign_key "deposits", "stocks"
  add_foreign_key "deposits", "users"
  add_foreign_key "stocks", "users"
  add_foreign_key "transfers", "users", column: "receiver_id"
  add_foreign_key "transfers", "users", column: "sender_id"
  add_foreign_key "withdraws", "stocks"
  add_foreign_key "withdraws", "users"
end
