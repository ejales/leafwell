class CreateMedicalAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :medical_answers do |t|
      t.references :medical_question, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true
      t.boolean :value

      t.timestamps
    end
  end
end
