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

ActiveRecord::Schema.define(version: 20130626065312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "basic_applicabilities", force: true do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "calculation", null: false
  end

  create_table "basic_compensations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "calculation", null: false
  end

  create_table "commission_schedules", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deal_id",                    null: false
    t.integer  "rule_id",                    null: false
    t.datetime "commission_calculated_date"
    t.datetime "calculate_commission_date"
    t.datetime "commission_payment_date"
  end

  create_table "commissions", force: true do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "payment_date",    null: false
    t.decimal  "amount",          null: false
    t.integer  "user_id",         null: false
    t.integer  "organization_id"
    t.integer  "deal_id"
    t.integer  "rule_id"
  end

  create_table "date_offset_calculation_dates", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "event_type", null: false
    t.string   "modifier",   null: false
    t.integer  "day_count",  null: false
  end

  create_table "date_offset_payment_dates", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "event_type", null: false
    t.string   "modifier",   null: false
    t.integer  "day_count",  null: false
  end

  create_table "deals", force: true do |t|
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "name",                  null: false
    t.decimal  "amount",                null: false
    t.datetime "sell_date",             null: false
    t.datetime "start_date",            null: false
    t.datetime "end_date"
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "rules_associated_date"
  end

  create_table "organizations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       null: false
  end

  create_table "rules", force: true do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "name",                         null: false
    t.boolean  "active",                       null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "calculation_date_engine_id",   null: false
    t.string   "calculation_date_engine_type", null: false
    t.integer  "payment_date_engine_id",       null: false
    t.string   "payment_date_engine_type",     null: false
    t.integer  "compensation_engine_id",       null: false
    t.string   "compensation_engine_type",     null: false
    t.integer  "applicability_engine_id",      null: false
    t.string   "applicability_engine_type",    null: false
    t.integer  "organization_id",              null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "organization_id"
    t.string   "roles",                                            array: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
