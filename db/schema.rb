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

ActiveRecord::Schema[7.1].define(version: 2024_07_18_093411) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adoption_pets", force: :cascade do |t|
    t.bigint "adoption_id", null: false
    t.bigint "pet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approved"
    t.index ["adoption_id"], name: "index_adoption_pets_on_adoption_id"
    t.index ["pet_id"], name: "index_adoption_pets_on_pet_id"
  end

  create_table "adoptions", force: :cascade do |t|
    t.string "name"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.text "description"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pets", force: :cascade do |t|
    t.boolean "adoptable"
    t.integer "age"
    t.string "breed"
    t.string "name"
    t.bigint "shelter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shelter_id"], name: "index_pets_on_shelter_id"
  end

  create_table "shelters", force: :cascade do |t|
    t.boolean "foster_program"
    t.string "name"
    t.string "city"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "veterinarians", force: :cascade do |t|
    t.boolean "on_call"
    t.integer "review_rating"
    t.string "name"
    t.bigint "veterinary_office_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["veterinary_office_id"], name: "index_veterinarians_on_veterinary_office_id"
  end

  create_table "veterinary_offices", force: :cascade do |t|
    t.boolean "boarding_services"
    t.integer "max_patient_capacity"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "adoption_pets", "adoptions"
  add_foreign_key "adoption_pets", "pets"
  add_foreign_key "pets", "shelters"
  add_foreign_key "veterinarians", "veterinary_offices"
end
