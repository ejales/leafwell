ActiveAdmin.register Patient do
  permit_params :first_name, :last_name, :insurance_provider, :fitness_activity

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :user
    column :insurance_provider
    column :fitness_activity
    column :created_at
    actions
  end

  filter :first_name
  filter :last_name
  filter :user
  filter :insurance_provider
  filter :fitness_activity
  filter :created_at

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :insurance_provider
      f.input :fitness_activity
      f.input :date_of_birth
      f.input :gender
      f.input :phone_number
      f.input :address
      f.input :country, as: :string
      f.input :state
      f.input :city
      f.input :zip_code
    end
    f.actions
  end
end
