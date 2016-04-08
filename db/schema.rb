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

ActiveRecord::Schema.define(version: 20160403103050) do

  create_table "users", force: :cascade do |t|
    t.string   "first_name",              limit: 255,                        null: false
    t.string   "last_name",               limit: 255,                        null: false
    t.string   "encrypted_email_address", limit: 255, default: "",           null: false
    t.string   "encrypted_phone_number",  limit: 255, default: "",           null: false
    t.string   "encrypted_zip_code",      limit: 255, default: "",           null: false
    t.string   "password_digest",         limit: 255,                        null: false
    t.string   "gender",                  limit: 255, default: ""
    t.date     "birthdate",                           default: '1900-01-01', null: false
    t.boolean  "disabled",                            default: false,        null: false
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
  end

  add_index "users", ["encrypted_email_address"], name: "index_users_on_encrypted_email_address", unique: true, using: :btree
  add_index "users", ["password_digest"], name: "index_users_on_password_digest", using: :btree

end
