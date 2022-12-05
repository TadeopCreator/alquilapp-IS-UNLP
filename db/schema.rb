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

ActiveRecord::Schema[7.0].define(version: 2022_12_05_204057) do
  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "lastname"
    t.string "dni"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "autos", force: :cascade do |t|
    t.integer "num_rel"
    t.string "patente"
    t.string "marca"
    t.string "modelo"
    t.string "color"
    t.boolean "alquilado", default: false
    t.boolean "habilitado"
    t.boolean "borrado", default: false
    t.decimal "lon"
    t.decimal "lat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.date "vto"
    t.integer "cvv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "globals", force: :cascade do |t|
    t.float "monto_auto"
    t.float "monto_multa"
    t.integer "cooldown"
    t.integer "tiempo_multa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "monto_extension"
  end

  create_table "historials", force: :cascade do |t|
    t.integer "id_usr"
    t.integer "id_auto"
    t.datetime "fin"
    t.integer "tiempoAlquilado"
    t.float "precio"
    t.float "pextra"
    t.boolean "multa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tiempo_extension"
    t.float "precio_multa"
    t.float "total"
  end

  create_table "reports", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "patente"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supervisors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "surname"
    t.string "dni"
    t.boolean "habilitado"
    t.boolean "borrado"
    t.string "contact"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.integer "id_rol"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "name"
    t.string "lastname"
    t.string "dni"
    t.string "contact"
    t.decimal "lon"
    t.decimal "lat"
    t.boolean "deleted"
    t.boolean "enable"
    t.date "birthdate"
    t.text "image_data"
    t.date "date_licence"
    t.integer "id_wallet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "send_license"
    t.boolean "alquilando"
  end

  create_table "wallets", force: :cascade do |t|
    t.float "saldo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
