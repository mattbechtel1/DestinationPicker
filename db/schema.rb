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

ActiveRecord::Schema[7.0].define(version: 2024_02_25_012851) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "destinations", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.bigint "language_primary_id", null: false
    t.bigint "language_secondary_id"
    t.string "flag_primary_id", null: false
    t.string "flag_secondary_id"
    t.text "breakdown"
    t.bigint "region_id", null: false
    t.integer "population"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flag_primary_id"], name: "index_destinations_on_flag_primary_id"
    t.index ["flag_secondary_id"], name: "index_destinations_on_flag_secondary_id"
    t.index ["language_primary_id"], name: "index_destinations_on_language_primary_id"
    t.index ["language_secondary_id"], name: "index_destinations_on_language_secondary_id"
    t.index ["region_id"], name: "index_destinations_on_region_id"
  end

  create_table "flags", primary_key: "code", id: { type: :string, limit: 2 }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "destinations", "flags", column: "flag_primary_id", primary_key: "code"
  add_foreign_key "destinations", "flags", column: "flag_secondary_id", primary_key: "code"
  add_foreign_key "destinations", "languages", column: "language_primary_id"
  add_foreign_key "destinations", "languages", column: "language_secondary_id"
  add_foreign_key "destinations", "regions"
end
