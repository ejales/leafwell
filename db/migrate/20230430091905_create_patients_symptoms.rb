class CreatePatientsSymptoms < ActiveRecord::Migration[7.0]
  def change
    create_table :patients_symptoms do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :symptom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
