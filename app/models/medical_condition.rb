class MedicalCondition < ApplicationRecord
  has_and_belongs_to_many :patients
  has_many :medical_questions, dependent: :destroy

  accepts_nested_attributes_for :medical_questions, allow_destroy: true
end
