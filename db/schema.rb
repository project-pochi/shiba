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

ActiveRecord::Schema.define(version: 20160603181933) do

  create_table "locations", force: :cascade do |t|
    t.string   "zip_code",   limit: 255, null: false
    t.float    "latitude",   limit: 24,  null: false
    t.float    "longitude",  limit: 24,  null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "locations", ["zip_code"], name: "index_locations_on_zip_code", unique: true, using: :btree

  create_table "sitters", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "residence_type_id", limit: 4
    t.integer  "capacity_type_id",  limit: 4
    t.date     "has_dog_from"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "sitters", ["capacity_type_id"], name: "index_sitters_on_capacity_type_id", using: :btree
  add_index "sitters", ["residence_type_id"], name: "index_sitters_on_residence_type_id", using: :btree
  add_index "sitters", ["user_id"], name: "index_sitters_on_user_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",              limit: 255,                        null: false
    t.string   "last_name",               limit: 255,                        null: false
    t.string   "nickname",                limit: 255,                        null: false
    t.string   "encrypted_email_address", limit: 255, default: "",           null: false
    t.string   "encrypted_phone_number",  limit: 255, default: "",           null: false
    t.string   "encrypted_zip_code",      limit: 255, default: "",           null: false
    t.string   "password_digest",         limit: 255,                        null: false
    t.string   "gender",                  limit: 255, default: ""
    t.date     "birthdate",                           default: '1900-01-01', null: false
    t.boolean  "activated",                           default: false,        null: false
    t.datetime "activated_at"
    t.string   "activation_digest",       limit: 255
    t.string   "remember_digest",         limit: 255
    t.string   "reset_digest",            limit: 255
    t.datetime "reset_sent_at"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
  end

  add_index "users", ["encrypted_email_address"], name: "index_users_on_encrypted_email_address", unique: true, using: :btree
  add_index "users", ["password_digest"], name: "index_users_on_password_digest", using: :btree

end
