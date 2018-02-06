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

ActiveRecord::Schema.define(version: 20180206000719) do

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.datetime "event_date", null: false
    t.boolean "all_day", default: false, null: false
    t.string "description"
    t.string "location", null: false
    t.float "location_lat"
    t.float "location_lon"
    t.string "category", null: false
    t.string "fbID"
    t.boolean "twentyone", default: false, null: false
    t.boolean "recurring"
    t.string "recurrence_freq"
    t.integer "recurrence_amt"
    t.integer "org_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display_category"
    t.boolean "featured", default: false
    t.string "featured_snippet", limit: 200
    t.index ["org_id"], name: "index_events_on_org_id"
  end

  create_table "orgs", force: :cascade do |t|
    t.string "name", null: false
    t.string "bio"
    t.string "fbID"
    t.string "category", null: false
    t.string "website"
    t.string "photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orgs_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "org_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["org_id"], name: "index_orgs_users_on_org_id"
    t.index ["user_id"], name: "index_orgs_users_on_user_id"
  end

  create_table "penn_fb_members", id: false, force: :cascade do |t|
    t.string "fbID"
    t.string "name"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid", null: false
    t.string "full_name", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "image_url"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
