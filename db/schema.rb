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

ActiveRecord::Schema[7.0].define(version: 2023_04_30_092520) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "medical_answers", force: :cascade do |t|
    t.bigint "medical_question_id", null: false
    t.bigint "patient_id", null: false
    t.boolean "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medical_question_id"], name: "index_medical_answers_on_medical_question_id"
    t.index ["patient_id"], name: "index_medical_answers_on_patient_id"
  end

  create_table "medical_conditions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medical_conditions_patients", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "medical_condition_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medical_condition_id"], name: "index_medical_conditions_patients_on_medical_condition_id"
    t.index ["patient_id"], name: "index_medical_conditions_patients_on_patient_id"
  end

  create_table "medical_questions", force: :cascade do |t|
    t.bigint "medical_condition_id", null: false
    t.string "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medical_condition_id"], name: "index_medical_questions_on_medical_condition_id"
  end

  create_table "patients", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.string "gender"
    t.string "phone_number"
    t.string "insurance_provider"
    t.string "fitness_activity"
    t.string "address"
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_patients_on_user_id"
  end

  create_table "patients_symptoms", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "symptom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_patients_symptoms_on_patient_id"
    t.index ["symptom_id"], name: "index_patients_symptoms_on_symptom_id"
  end

  create_table "symptoms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "medical_answers", "medical_questions"
  add_foreign_key "medical_answers", "patients"
  add_foreign_key "medical_conditions_patients", "medical_conditions"
  add_foreign_key "medical_conditions_patients", "patients"
  add_foreign_key "medical_questions", "medical_conditions"
  add_foreign_key "patients", "users"
  add_foreign_key "patients_symptoms", "patients"
  add_foreign_key "patients_symptoms", "symptoms"
end
