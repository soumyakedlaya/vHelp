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

ActiveRecord::Schema.define(version: 20170304045620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charity_reps", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "charity_name"
    t.text     "charitable_cause"
    t.integer  "money_requested"
    t.integer  "money_raised"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donations", force: true do |t|
    t.integer  "amount"
    t.integer  "charity_rep_id"
    t.integer  "donor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "donations", ["charity_rep_id"], name: "index_donations_on_charity_rep_id", using: :btree
  add_index "donations", ["donor_id"], name: "index_donations_on_donor_id", using: :btree

  create_table "donors", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "money_available"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
