class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :gender
      t.string :phone_number
      t.string :insurance_provider
      t.string :fitness_activity
      t.string :address
      t.string :country
      t.string :state
      t.string :city
      t.string :zip_code

      t.timestamps
    end
  end
end
