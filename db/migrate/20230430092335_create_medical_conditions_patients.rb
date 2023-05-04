class CreateMedicalConditionsPatients < ActiveRecord::Migration[7.0]
  def change
    create_table :medical_conditions_patients do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :medical_condition, null: false, foreign_key: true

      t.timestamps
    end
  end
end
