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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110608044939) do

  create_table "battle_participations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "battle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "battles", :force => true do |t|
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_winner_id"
  end

  create_table "location_links", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "origin_id"
    t.integer  "destination_id"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.integer  "posx"
    t.integer  "posy"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "map_id"
    t.integer  "owner_team_id"
    t.integer  "homeworld"
  end

  create_table "maps", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "match_id"
  end

  create_table "match_participations", :force => true do |t|
    t.integer  "team_id"
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_winner_id"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "teamname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "captain_user_id"
  end

  create_table "user_locations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "location_id"
    t.integer  "match_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
