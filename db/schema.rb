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

ActiveRecord::Schema.define(version: 2019_08_24_064103) do

  create_table "employees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meeting_rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meetings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "meeting_room_id"
    t.boolean "is_occupied"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_room_id"], name: "index_meetings_on_meeting_room_id"
  end

  create_table "scheduled_meetings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "meeting_id"
    t.boolean "is_accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_scheduled_meetings_on_employee_id"
    t.index ["meeting_id"], name: "index_scheduled_meetings_on_meeting_id"
  end

  add_foreign_key "scheduled_meetings", "employees"
  add_foreign_key "scheduled_meetings", "meetings"
end
