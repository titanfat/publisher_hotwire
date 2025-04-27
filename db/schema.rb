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

ActiveRecord::Schema[8.0].define(version: 2025_04_25_183620) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "doi"
    t.bigint "journal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["journal_id"], name: "index_articles_on_journal_id"
  end

  create_table "authors_posts", force: :cascade do |t|
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
    t.index ["publishable_type", "publishable_id"], name: "index_posts_on_publishable_type_and_publishable_id", unique: true
  end

  create_table "reports", force: :cascade do |t|
    t.string "conference_name"
    t.string "conference_place"
    t.bigint "reporter_id", null: false
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
    t.virtual "searchable_full_name", type: :tsvector, as: "(setweight(to_tsvector('simple'::regconfig, (COALESCE(first_name, ''::character varying))::text), 'A'::\"char\") || setweight(to_tsvector('simple'::regconfig, (COALESCE(last_name, ''::character varying))::text), 'B'::\"char\"))", stored: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["searchable_full_name"], name: "index_users_on_searchable_full_name", using: :gin
    t.check_constraint "email IS NOT NULL"
    t.check_constraint "password_digest IS NOT NULL"
  end

  add_foreign_key "articles", "journals"
  add_foreign_key "authors_posts", "posts"
  add_foreign_key "authors_posts", "users"
  add_foreign_key "reports", "users", column: "reporter_id"
  add_foreign_key "sessions", "users"

  create_view "post_searches", materialized: true, sql_definition: <<-SQL
      SELECT p.id AS post_id,
      ((to_tsvector('simple'::regconfig, (COALESCE(p.title, ''::character varying))::text) || to_tsvector('simple'::regconfig, (COALESCE(p.original_title, ''::character varying))::text)) || to_tsvector('simple'::regconfig, COALESCE(string_agg(concat(u.first_name, '', u.last_name), ' ; '::text)))) AS tsv_document
     FROM ((posts p
       JOIN authors_posts ap ON ((p.id = ap.post_id)))
       JOIN users u ON ((u.id = ap.user_id)))
    GROUP BY p.id, p.title, p.original_title;
  SQL
  add_index "post_searches", ["tsv_document"], name: "index_post_searches_on_tsv_document", using: :gin

end
