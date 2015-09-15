# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150915060718) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sales_histories", force: :cascade do |t|
    t.decimal  "sale_price",                      precision: 15, scale: 2
    t.float    "sales_count",                                              default: 0.0
    t.integer  "trade_object_id"
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.datetime "date_of_implementation_strategy"
    t.decimal  "actual_current_price",            precision: 15, scale: 2
  end

  add_index "sales_histories", ["trade_object_id"], name: "index_sales_histories_on_trade_object_id", using: :btree

  create_table "trade_objects", force: :cascade do |t|
    t.string   "name"
    t.string   "object_type"
    t.decimal  "current_price",                precision: 15, scale: 2
    t.decimal  "minimum_price",                precision: 15, scale: 2
    t.float    "sales_count",                                           default: 0.0
    t.float    "total_count_of_sales",                                  default: 0.0
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.decimal  "actual_current_price",         precision: 15, scale: 2
    t.decimal  "average_actual_current_price", precision: 15, scale: 2
  end

  add_foreign_key "sales_histories", "trade_objects"
end
