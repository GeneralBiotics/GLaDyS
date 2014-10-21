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

ActiveRecord::Schema.define(version: 20141021000051) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer  "question_id",    limit: 8
    t.integer  "participant_id"
    t.integer  "token_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "contact_method"
    t.string   "email"
    t.string   "phone_number"
    t.boolean  "drop_out",        default: false
    t.text     "drop_out_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "kind"
    t.boolean  "required"
    t.text     "question_text"
    t.text     "detailed_description"
    t.text     "options_for_select"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studies", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tokens", force: true do |t|
    t.integer  "participant_id"
    t.string   "value"
    t.datetime "created_at"
  end

end
