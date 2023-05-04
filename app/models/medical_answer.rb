class MedicalAnswer < ApplicationRecord
  belongs_to :medical_question
  belongs_to :patient

  validates :value, inclusion: { in: [ true, false ] }

end
