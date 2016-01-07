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

ActiveRecord::Schema.define(version: 20160107003953) do

  create_table "subscribers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "art"
    t.boolean  "allcategories"
    t.boolean  "comics"
    t.boolean  "crafts"
    t.boolean  "dance"
    t.boolean  "design"
    t.boolean  "fashion"
    t.boolean  "filmvideo"
    t.boolean  "food"
    t.boolean  "games"
    t.boolean  "journalism"
    t.boolean  "music"
    t.boolean  "photography"
    t.boolean  "publishing"
    t.boolean  "technology"
    t.boolean  "theater"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "token"
    t.boolean  "active"
  end

end
