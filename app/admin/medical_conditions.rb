ActiveAdmin.register MedicalCondition do
  permit_params :name, medical_questions_attributes: [:id, :_destroy, :question]

  config.sort_order = "id_desc"

  index do
    id_column
    column(:id)
    column(:name)
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.has_many(
            :medical_questions,
            heading: "Medical Questions",
            allow_destroy: true,
            new_record: true,
          ) do |item|
            item.input(:question)
          end
    end
    f.actions
  end

  show do
    attributes_table do
      row(:name)
      row(:created_at)
      row(:updated_at)
    end
    panel("Medical Questions") do
      table_for resource.medical_questions do
        column(:question)
        column(:created_at)
        column(:updated_at)
      end
    end
  end
end
