class PatientsSymptom < ApplicationRecord
  belongs_to :patient
  belongs_to :symptom
end
