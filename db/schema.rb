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

ActiveRecord::Schema[7.0].define(version: 2024_01_05_111016) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "champions", force: :cascade do |t|
    t.string "riot_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.string "riot_id"
    t.boolean "win"
    t.bigint "champion_id"
    t.integer "kills"
    t.integer "deaths"
    t.integer "assists"
    t.integer "duration"
    t.float "cs_per_minute"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "remake", default: false
    t.index ["champion_id"], name: "index_matches_on_champion_id"
  end

  add_foreign_key "matches", "champions"
end
