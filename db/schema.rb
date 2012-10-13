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

ActiveRecord::Schema.define(:version => 20121013174504) do

  create_table "recommendations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "repo_id"
    t.integer  "score",      :default => 0
    t.boolean  "skip",       :default => false
    t.integer  "skip_type",  :default => 0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "recommendations", ["skip"], :name => "index_recommendations_on_skip"
  add_index "recommendations", ["skip_type"], :name => "index_recommendations_on_skip_type"
  add_index "recommendations", ["user_id", "repo_id"], :name => "index_recommendations_on_user_id_and_repo_id", :unique => true
  add_index "recommendations", ["user_id", "score"], :name => "index_recommendations_on_user_id_and_score"

  create_table "repos", :force => true do |t|
    t.string   "name"
    t.string   "language"
    t.integer  "owner_id"
    t.integer  "forks_count", :default => 0
    t.integer  "stars_count", :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "repos", ["name", "owner_id"], :name => "index_repos_on_name_and_owner_id", :unique => true

  create_table "scores", :force => true do |t|
    t.integer  "value",             :default => 0
    t.integer  "action_type",       :default => 0
    t.integer  "recommendation_id"
    t.integer  "user_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
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

  create_table "user_followings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "following_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "user_followings", ["user_id", "following_id"], :name => "index_user_followings_on_user_id_and_following_id", :unique => true

  create_table "users", :force => true do |t|
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

end
