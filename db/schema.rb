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

ActiveRecord::Schema[8.2].define(version: 2026_03_27_132303) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "orders", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, default: "0.0", null: false
    t.bigint "client_id", null: false
    t.bigint "coach_id", null: false
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.string "idempotency_key"
    t.integer "status", default: 0, null: false
    t.bigint "tenant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["coach_id"], name: "index_orders_on_coach_id"
    t.index ["idempotency_key"], name: "index_orders_on_idempotency_key", unique: true
    t.index ["tenant_id", "client_id", "status"], name: "idx_orders_on_tenant_client_status"
    t.index ["tenant_id"], name: "index_orders_on_tenant_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "invitation_token"
    t.string "name"
    t.integer "orders_count"
    t.string "subdomain"
    t.datetime "updated_at", null: false
    t.index ["invitation_token"], name: "index_tenants_on_invitation_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.integer "role"
    t.bigint "tenant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_users_on_tenant_id"
  end

  add_foreign_key "orders", "tenants"
  add_foreign_key "orders", "users", column: "client_id"
  add_foreign_key "orders", "users", column: "coach_id"
  add_foreign_key "users", "tenants"
end
