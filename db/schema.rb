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

ActiveRecord::Schema.define(version: 2024_02_22_032702) do

  create_table "attendees", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.string "phone_number"
    t.string "address"
    t.string "credit_card_info"
    t.boolean "is_admin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_attendees_on_email", unique: true
  end

  create_table "event_tickets", force: :cascade do |t|
    t.integer "attendee_id", null: false
    t.integer "event_id", null: false
    t.string "confirmation_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number_of_tickets"
    t.decimal "total_cost"
    t.integer "buyer_id"
    t.index ["attendee_id"], name: "index_event_tickets_on_attendee_id"
    t.index ["event_id"], name: "index_event_tickets_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.integer "room_id", null: false
    t.string "category"
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.decimal "ticket_price"
    t.integer "number_of_seats_left"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_events_on_room_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "attendee_id", null: false
    t.integer "event_id", null: false
    t.integer "rating"
    t.text "feedback"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attendee_id"], name: "index_reviews_on_attendee_id"
    t.index ["event_id"], name: "index_reviews_on_event_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "location"
    t.integer "capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "event_tickets", "attendees"
  add_foreign_key "event_tickets", "events"
  add_foreign_key "events", "rooms"
  add_foreign_key "reviews", "attendees"
  add_foreign_key "reviews", "events"
end
