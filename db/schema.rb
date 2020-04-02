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

ActiveRecord::Schema.define(version: 2019_10_13_160905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "city_id"
    t.string "f_name"
    t.string "l_name"
    t.text "description"
    t.string "email"
    t.integer "age"
    t.string "password_digest"
    t.string "remember_digest"
    t.index ["city_id"], name: "index_authors_on_city_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.index ["author_id"], name: "index_comments_on_author_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_conversations_on_recipient_id"
    t.index ["sender_id"], name: "index_conversations_on_sender_id"
  end

  create_table "gossips", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id"
    t.bigint "tag_id"
    t.index ["author_id"], name: "index_gossips_on_author_id"
    t.index ["tag_id"], name: "index_gossips_on_tag_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "author_id"
    t.bigint "gossip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_likes_on_author_id"
    t.index ["gossip_id"], name: "index_likes_on_gossip_id"
  end

  create_table "private_messages", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id"
    t.bigint "author_id"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_private_messages_on_author_id"
    t.index ["conversation_id"], name: "index_private_messages_on_conversation_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "authors", "cities"
  add_foreign_key "comments", "authors"
  add_foreign_key "gossips", "authors"
  add_foreign_key "gossips", "tags"
end
