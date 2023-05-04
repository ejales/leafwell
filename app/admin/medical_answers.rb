ActiveAdmin.register MedicalAnswer do

  filter(
    :medical_question,
    as: :searchable_select,
    collection: -> { MedicalQuestion.all.map { |mq| [mq.question, mq.id] } },
  )
  filter(:patient)
  filter(:value)
  filter(:created_at)
  filter(:updated_at)

  index do
    column(:id)
    column(:medical_question) { |ma| link_to ma.medical_question.question, admin_medical_question_path(ma.medical_question.id) }
    column(:patient) { |ma| link_to ma.patient.full_name, admin_patient_path(ma.patient.id) }
    column(:value)
    column(:created_at)
    column(:updated_at)
  end
end
