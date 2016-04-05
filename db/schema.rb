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

ActiveRecord::Schema.define(version: 20160405160337) do

  create_table "chat_users", force: :cascade do |t|
    t.integer  "chat_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chat_users", ["chat_id", "user_id"], name: "index_chat_users_on_chat_id_and_user_id", unique: true
  add_index "chat_users", ["chat_id"], name: "index_chat_users_on_chat_id"
  add_index "chat_users", ["user_id"], name: "index_chat_users_on_user_id"

  create_table "chats", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "private",    default: false
  end

  create_table "deleted_messages", force: :cascade do |t|
    t.integer  "message_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "deleted_messages", ["message_id", "user_id"], name: "index_deleted_messages_on_message_id_and_user_id", unique: true
  add_index "deleted_messages", ["message_id"], name: "index_deleted_messages_on_message_id"
  add_index "deleted_messages", ["user_id"], name: "index_deleted_messages_on_user_id"

  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "last_activity_at", default: '2016-04-05 16:06:17', null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
