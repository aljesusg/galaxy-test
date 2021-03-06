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

ActiveRecord::Schema.define(version: 20171116160422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "git_hub_repos", force: :cascade do |t|
    t.string "name"
    t.string "full_name"
    t.string "description"
    t.string "homepage"
    t.string "ssh_url"
    t.string "clone_url"
    t.string "html_url"
    t.integer "forks_count"
    t.integer "stargazers_count"
    t.integer "watchers_count"
    t.datetime "gh_created_at"
    t.datetime "gh_pushed_at"
    t.datetime "gh_updated_at"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "gh_id"
    t.boolean "fork"
    t.boolean "archived"
    t.integer "open_issues_count"
    t.string "default_branch"
    t.string "issues_url"
    t.string "owner_login"
    t.index ["user_id"], name: "index_git_hub_repos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "short_name", null: false
    t.boolean "admin", default: false, null: false
    t.boolean "staff", default: false, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at"
    t.integer "karma", default: 0
    t.string "github_avatar"
    t.string "github_user"
    t.boolean "cache_refreshed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["karma"], name: "index_users_on_karma"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "git_hub_repos", "users"
end
