ActiveRecord::Schema.define(version: 20150222010340) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.text     "original_text"
    t.text     "translated_text"
    t.date     "review_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end
end
