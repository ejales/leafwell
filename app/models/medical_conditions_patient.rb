class MedicalConditionsPatient < ApplicationRecord
  belongs_to :patient
  belongs_to :medical_condition
end
