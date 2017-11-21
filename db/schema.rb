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

# <<<<<<< HEAD
# ActiveRecord::Schema.define(version: 20171111202136) do
# =======
ActiveRecord::Schema.define(version: 20171116210948) do

  create_table "body_part_symptom_diseases", force: :cascade do |t|
    t.integer "body_part_id"
    t.integer "symptom_id"
    t.integer "disease_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "body_parts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.integer "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "phone"
    t.string "street"
    t.string "street2"
    t.string "state"
    t.string "country"
    t.string "zipcode"
    t.string "fax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "copays", force: :cascade do |t|
    t.float "in_network"
    t.float "out_network"
    t.integer "plan_id"
    t.integer "treatment_id"
    t.boolean "copay_or_coinsurance_in"
    t.boolean "copay_or_coinsurance_out"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diseases", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "facilities", force: :cascade do |t|
    t.string "name"
    t.string "specialty"
    t.string "open_hour"
    t.integer "contact_id"
    t.string "email"
    t.string "phone_number"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logs", force: :cascade do |t|
    t.integer "symptom_id"
    t.integer "severity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "visit_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.integer "company_id"
    t.float "deductible"
    t.float "out_of_pocket_max"
    t.float "inpatient_copay"
    t.float "outpatient_copay"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans_users", id: false, force: :cascade do |t|
    t.integer "plan_id"
    t.integer "user_id"
    t.index ["plan_id"], name: "index_plans_users_on_plan_id"
    t.index ["user_id"], name: "index_plans_users_on_user_id"
  end

  create_table "symptoms", force: :cascade do |t|
    t.string "name"
    t.integer "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "treatments", force: :cascade do |t|
    t.string "name"
    t.string "resource_category"
    t.integer "disease_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer "contact_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "email"

    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer "user_id"
    t.string "picture"
  end

  create_table "visits", force: :cascade do |t|
    t.date "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "vtype"
  end

end
