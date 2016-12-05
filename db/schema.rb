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

ActiveRecord::Schema.define(version: 20161201050922) do

  create_table "chg_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "depts", force: :cascade do |t|
    t.string   "name"
    t.boolean  "project"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doc_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flow_orders", force: :cascade do |t|
    t.integer  "order"
    t.boolean  "project_flg"
    t.integer  "dept_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "reject_permission"
    t.boolean  "first_to_revert_permission"
  end

  add_index "flow_orders", ["dept_id"], name: "index_flow_orders_on_dept_id"

  create_table "flows", force: :cascade do |t|
    t.integer  "request_application_id"
    t.integer  "order"
    t.integer  "dept_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "history_no"
    t.text     "memo"
  end

  add_index "flows", ["dept_id"], name: "index_flows_on_dept_id"
  add_index "flows", ["request_application_id"], name: "index_flows_on_request_application_id"

  create_table "models", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "progresses", force: :cascade do |t|
    t.integer  "flow_id"
    t.datetime "in_date"
    t.datetime "out_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "progresses", ["flow_id"], name: "index_progresses_on_flow_id"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "request_applications", force: :cascade do |t|
    t.string   "management_no"
    t.boolean  "emargency"
    t.string   "filename"
    t.date     "request_date"
    t.date     "preferred_date"
    t.boolean  "close"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "project_id"
    t.text     "memo"
    t.integer  "model_id"
    t.integer  "section_id"
  end

  create_table "request_details", force: :cascade do |t|
    t.integer  "request_application_id"
    t.string   "doc_no"
    t.string   "sht"
    t.string   "rev"
    t.string   "eo_chgno"
    t.string   "mcl"
    t.string   "scp_for_smpl"
    t.string   "scml_ln"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "doc_type_id"
    t.integer  "chg_type_id"
    t.integer  "vendor_id"
  end

  add_index "request_details", ["chg_type_id"], name: "index_request_details_on_chg_type_id"
  add_index "request_details", ["doc_type_id"], name: "index_request_details_on_doc_type_id"
  add_index "request_details", ["request_application_id"], name: "index_request_details_on_request_application_id"
  add_index "request_details", ["vendor_id"], name: "index_request_details_on_vendor_id"

  create_table "sections", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.integer  "dept_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["dept_id"], name: "index_users_on_dept_id"

  create_table "vendors", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
