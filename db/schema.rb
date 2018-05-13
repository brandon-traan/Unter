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

ActiveRecord::Schema.define(version: 20180513162133) do

  create_table "bookings", force: :cascade do |t|
    t.integer "users_id"
    t.integer "cars_id"
    t.integer "user_id"
    t.string "users_firstname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_lastname"
    t.string "user_email"
    t.string "user_phone"
    t.string "car_make"
    t.string "car_model"
    t.string "car_year"
    t.string "car_size"
    t.string "car_price"
    t.datetime "pickup", null: false
    t.datetime "return", null: false
    t.datetime "expectedReturn", null: false
    t.string "Status", default: "Awaiting"
    t.index ["cars_id"], name: "index_bookings_on_cars_id"
    t.index ["users_id"], name: "index_bookings_on_users_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "make"
    t.string "model"
    t.string "year"
    t.string "size"
    t.string "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.string "status"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "phone"
    t.string "licenseN"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "role", default: "Customer"
    t.float "rentalCharge", default: 0.0
    t.boolean "available", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["licenseN"], name: "index_users_on_licenseN", unique: true
  end

end
