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

ActiveRecord::Schema[7.0].define(version: 2022_03_12_121159) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "housings", force: :cascade do |t|
    t.integer "ad_price"
    t.string "property_category"
    t.string "localization"
    t.integer "area"
    t.string "ad_url"
    t.text "comment"
    t.integer "offer_price"
    t.integer "repairs_price"
    t.integer "annual_rent"
    t.float "notary_fees"
    t.integer "agency_fees"
    t.boolean "pno_insurance"
    t.integer "property_tax"
    t.boolean "rental_management"
    t.boolean "rental_unpayment_insurance"
    t.integer "building_co_tax"
    t.float "maintenance_percentage"
    t.float "ad_profitability"
    t.float "offer_profitability"
    t.boolean "new_property"
    t.float "rental_vacancy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id", null: false
    t.index ["project_id"], name: "index_housings_on_project_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "localization"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "housings", "projects"
  add_foreign_key "projects", "users"
end
