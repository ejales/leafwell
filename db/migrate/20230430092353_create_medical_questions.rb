class CreateMedicalQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :medical_questions do |t|
      t.references :medical_condition, null: false, foreign_key: true
      t.string :question

      t.timestamps
    end
  end
end
