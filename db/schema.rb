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

ActiveRecord::Schema.define(version: 20150518222207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "brands", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "company_name",           limit: 255,              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "brands", ["email"], name: "index_brands_on_email", unique: true, using: :btree
  add_index "brands", ["reset_password_token"], name: "index_brands_on_reset_password_token", unique: true, using: :btree

  create_table "influencers", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name",                   limit: 255, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "influencers", ["email"], name: "index_influencers_on_email", unique: true, using: :btree
  add_index "influencers", ["reset_password_token"], name: "index_influencers_on_reset_password_token", unique: true, using: :btree

  create_table "instagram_accounts", force: :cascade do |t|
    t.string  "nickname",      limit: 255
    t.string  "name",          limit: 255
    t.string  "image_url",     limit: 255
    t.text    "bio"
    t.text    "website"
    t.integer "media"
    t.integer "followed_by"
    t.integer "follows"
    t.string  "access_token",  limit: 255
    t.integer "influencer_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "proposal_id"
    t.integer  "sender_id"
    t.string   "sender_type", limit: 255
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "source_id"
    t.string   "source_type", limit: 255
    t.integer  "target_id"
    t.string   "target_type", limit: 255
    t.boolean  "ignored",                 default: false
    t.string   "type",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",        limit: 255,                   null: false
    t.text     "description",                               null: false
    t.boolean  "published",               default: false
    t.integer  "price_low"
    t.integer  "price_high"
    t.integer  "brand_id",                                  null: false
    t.string   "image",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "private",                 default: false
    t.string   "status",      limit: 255, default: "draft"
    t.datetime "due_date"
    t.boolean  "has_goodies"
    t.boolean  "approved",                default: false
  end

  create_table "proposals", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "influencer_id"
    t.string   "status",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price"
  end

  create_table "videos", force: :cascade do |t|
    t.integer  "youtube_channel_id"
    t.integer  "likes_count"
    t.integer  "dislikes_count"
    t.integer  "views_count"
    t.integer  "comments_count"
    t.string   "thumbnail_url",      limit: 255
    t.string   "title",              limit: 255
    t.string   "youtube_video_id",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description",        limit: 255
  end

  create_table "words", force: :cascade do |t|
    t.string  "word"
    t.string  "source"
    t.integer "year"
    t.integer "month"
    t.integer "mentions"
  end

  add_index "words", ["word"], name: "index_words_on_word", using: :btree

  create_table "youtube_channels", force: :cascade do |t|
    t.string  "title",         limit: 255
    t.text    "description"
    t.string  "image_url",     limit: 255
    t.integer "subscribers"
    t.string  "access_token",  limit: 255
    t.string  "refresh_token", limit: 255
    t.integer "influencer_id"
  end

end
