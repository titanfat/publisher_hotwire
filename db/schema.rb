# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_03_28_023318) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "doi"
    t.bigint "journal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["journal_id"], name: "index_articles_on_journal_id"
  end

  create_table "authors_posts", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.index ["post_id"], name: "index_authors_posts_on_post_id"
    t.index ["user_id", "post_id"], name: "index_authors_posts_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_authors_posts_on_user_id"
  end

  create_table "chapters", force: :cascade do |t|
    t.string "publisher"
    t.string "isbn"
    t.integer "page_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "journals", force: :cascade do |t|
    t.string "title"
    t.string "issn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "publishable_id", null: false
    t.string "publishable_type", null: false
    t.string "title", null: false
    t.string "original_title"
    t.date "date_publishing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publishable_id", "publishable_type"], name: "post_index_types"
  end

  create_table "reports", force: :cascade do |t|
    t.string "conference_name"
    t.string "conference_place"
    t.integer "reporter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reporter_id"], name: "index_reports_on_reporter_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name"
    t.string "second_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "orcid"
    t.string "email"
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.check_constraint "email IS NOT NULL"
    t.check_constraint "password_digest IS NOT NULL"
  end

  add_foreign_key "articles", "journals"
  add_foreign_key "authors_posts", "posts"
  add_foreign_key "authors_posts", "users"
  add_foreign_key "reports", "users", column: "reporter_id"
  add_foreign_key "sessions", "users"
end
