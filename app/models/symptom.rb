class Symptom < ApplicationRecord
  has_and_belongs_to_many :patients
end
