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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121127230720) do

  create_table "candidates", :force => true do |t|
    t.string  "name"
    t.integer "election_id"
  end

  create_table "candidates_positions", :force => true do |t|
    t.integer "candidate_id"
    t.integer "position_id"
  end

  add_index "candidates_positions", ["candidate_id", "position_id"], :name => "index_candidates_positions_on_candidate_id_and_position_id", :unique => true

  create_table "elections", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "elections_users", :force => true do |t|
    t.integer "election_id"
    t.integer "user_id"
  end

  add_index "elections_users", ["election_id", "user_id"], :name => "index_elections_users_on_election_id_and_user_id", :unique => true

  create_table "positions", :force => true do |t|
    t.string  "title"
    t.integer "election_id"
  end

  create_table "users", :force => true do |t|
    t.string   "password"
    t.boolean  "is_admin",   :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "position_id"
    t.integer  "rank"
    t.integer  "candidate_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "votes", ["user_id", "position_id", "rank"], :name => "index_votes_on_user_id_and_position_id_and_rank", :unique => true

end
