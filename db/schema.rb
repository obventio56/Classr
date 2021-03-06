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

ActiveRecord::Schema.define(version: 20150815161012) do

  create_table "courses", force: :cascade do |t|
    t.string   "title"
    t.integer  "creator_id"
    t.string   "status"
    t.string   "visibility"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "courses", ["creator_id"], name: "index_courses_on_creator_id"

  create_table "group_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "group_roles", ["group_id"], name: "index_group_roles_on_group_id"
  add_index "group_roles", ["role_id"], name: "index_group_roles_on_role_id"

  create_table "groups", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "groups", ["course_id"], name: "index_groups_on_course_id"
  add_index "groups", ["teacher_id"], name: "index_groups_on_teacher_id"

  create_table "roles", force: :cascade do |t|
    t.string   "role_type"
    t.integer  "user_id"
    t.integer  "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "visibility"
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "role_id"
    t.string   "visibility"
  end

  add_index "schools", ["role_id"], name: "index_schools_on_role_id"

  create_table "tests", force: :cascade do |t|
    t.text     "html"
    t.text     "questions_and_answers"
    t.integer  "role_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.text     "original_html"
  end

  add_index "tests", ["role_id"], name: "index_tests_on_role_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "white_list_entries", force: :cascade do |t|
    t.string   "entry"
    t.string   "entry_type"
    t.string   "for_role_type"
    t.integer  "school_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "white_list_entries", ["school_id"], name: "index_white_list_entries_on_school_id"

end
