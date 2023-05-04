class MedicalQuestion < ApplicationRecord
  belongs_to :medical_condition
  has_one :medical_answer
end
