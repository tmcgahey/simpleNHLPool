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

ActiveRecord::Schema.define(version: 20140510022752) do

  create_table "goalies", force: true do |t|
    t.string   "name"
    t.string   "team"
    t.integer  "wins"
    t.integer  "so"
    t.integer  "pool_member_id"
    t.integer  "nhl_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nhl_team_id"
    t.integer  "goals"
    t.integer  "assists"
  end

  add_index "goalies", ["nhl_team_id"], name: "index_goalies_on_nhl_team_id"
  add_index "goalies", ["pool_member_id"], name: "index_goalies_on_pool_member_id"

  create_table "nhl_teams", force: true do |t|
    t.string   "name"
    t.integer  "pool_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pool_members", force: true do |t|
    t.string   "name"
    t.integer  "pool_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "goalie1"
    t.string   "goalie2"
  end

  add_index "pool_members", ["pool_id"], name: "index_pool_members_on_pool_id"

  create_table "pools", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_update"
  end

  create_table "skaters", force: true do |t|
    t.string   "name"
    t.string   "team"
    t.string   "pos"
    t.integer  "goals"
    t.integer  "assists"
    t.integer  "pool_member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nhl_id"
    t.integer  "nhl_team_id"
  end

  add_index "skaters", ["nhl_id"], name: "index_skaters_on_nhl_id"
  add_index "skaters", ["nhl_team_id"], name: "index_skaters_on_nhl_team_id"
  add_index "skaters", ["pool_member_id"], name: "index_skaters_on_pool_member_id"

end
