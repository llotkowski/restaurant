# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090104112919) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cuisines", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meals", :force => true do |t|
    t.string   "name"
    t.text     "elements"
    t.float    "amount"
    t.string   "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "meal_photo_file_name"
    t.string   "meal_photo_content_type"
    t.integer  "meal_photo_file_size"
  end

  create_table "menus", :force => true do |t|
    t.integer  "restaurant_id"
    t.integer  "meal_id"
    t.integer  "category_id"
    t.float    "price"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.integer  "cuisine_id"
    t.string   "street"
    t.string   "number"
    t.string   "city"
    t.text     "desc"
    t.string   "phone"
    t.string   "email"
    t.string   "owner"
    t.float    "longitude"
    t.float    "latitude"
    t.float    "zoom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password"
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "isadmin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
