ActiveAdmin.register MedicalQuestion do
  permit_params :question, :medical_condition_id

  index do
    id_column
    column(:question)
    column(:medical_condition)
    column(:created_at)
    column(:updated_at)
    actions
  end
end
