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

ActiveRecord::Schema.define(:version => 20121013135105) do

  create_table "repos", :force => true do |t|
    t.string   "name"
    t.string   "language"
    t.integer  "owner_id"
    t.integer  "forks_count", :default => 0
    t.integer  "stars_count", :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "scores", :force => true do |t|
    t.string   "value"
    t.string   "action_type"
    t.integer  "recommendation_id"
    t.integer  "user_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "scores", ["recommendation_id"], :name => "index_scores_on_recommendation_id"
  add_index "scores", ["user_id"], :name => "index_scores_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.integer  "uid"
    t.string   "login"
    t.string   "email"
    t.string   "full_name"
    t.string   "avatar_url"
    t.string   "token"
    t.integer  "followings_count", :default => 0
    t.integer  "stars_count",      :default => 0
    t.integer  "repos_count",      :default => 0
    t.datetime "authorized_at"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "users", ["uid"], :name => "index_users_on_uid", :unique => true

end
