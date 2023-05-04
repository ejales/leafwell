namespace :dev do

  desc "Setup Development"
  task setup: :environment do
    puts "Running setup for development..."

    puts "Deleting database... #{%x(rails db:drop)}"

    puts "Creating database... #{%x(rails db:create)}"
    puts %x(rails db:migrate)
    puts %x(rails dev:generate_user_adm)
    puts %x(rails dev:generate_users)
    puts %x(rails dev:generate_symptoms)
    puts %x(rails dev:generate_patients)
    puts %x(rails dev:generate_medical_conditions)
    puts %x(rails dev:generate_medical_questions)
    
    puts "Configuration performed....[OK]"
  end

####################################################################

  desc "Create fake admin user"
  task generate_user_adm: :environment do

    puts "Registering the admin user..."
    User.create!(email: "admin@test.com", password: "123456", password_confirmation: "123456", username: 'admin', role: 1)

    puts "Registered admin user....[OK]"
  end

####################################################################

  desc "Create fake users"
  task generate_users: :environment do

    puts "Registering fake users..."

    30.times do
      begin
        User.create!(
          email: Faker::Internet.email,
          password: '123456',
          password_confirmation: '123456',
          username: Faker::Internet.username
        )
      rescue ActiveRecord::RecordInvalid => e
        puts "Error creating user: #{e.record.errors.full_messages.join(", ")}"
        retry
      end
    end

    puts "Registered fake users....[OK]"
  end

####################################################################

  desc "Create fake symptoms"
  task generate_symptoms: :environment do

    puts "Registering fake symptoms..."

    ['Sinus pain from congestion', 'Fatigue', 'Thirst', 'Chest pain', 'Loss of taste or smell'].each do |s|
      Symptom.create!(name: s)
    end

    puts "Registered fake symptoms....[OK]"
  end

####################################################################

  desc "Create fake patients"
  task generate_patients: :environment do

    puts "Registering fake patients..."

    User.where.not(role: 1).each do |u|
      Patient.create!(
        user: u,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        date_of_birth: Faker::Date.birthday,
        gender: Faker::Gender.type,
        phone_number: Faker::PhoneNumber.cell_phone,
        insurance_provider: Faker::Company.name,
        fitness_activity: Faker::Team.sport,
        address: Faker::Address.street_address,
        country: Faker::Address.country,
        state: Faker::Address.state,
        city: Faker::Address.city,
        zip_code: Faker::Address.zip
      )
    end

    puts "Registered fake patients....[OK]"
  end

####################################################################

  desc "Create fake medical_conditions"
  task generate_medical_conditions: :environment do

    puts "Registering fake medical_conditions..."

    ["ALS (Lou Gehrig's Disease)", "Alzheimer's Disease and other Dementias", 'Arthritis', 'Asthma', 'Cancer', 'Diabetes', 'Heart Disease', 'Obesity'].each do |s|
      MedicalCondition.create!(name: s)
    end

    puts "Registered fake medical_conditions....[OK]"
  end

####################################################################

  desc "Create fake medical_questions"
  task generate_medical_questions: :environment do

    puts "Registering fake medical_questions..."

    MedicalCondition.all.each do |mc|
      Random.rand(1..5).times do
          MedicalQuestion.create!(
            medical_condition_id: mc.id,
            question: Faker::Lorem.question
          )
      end
    end

    puts "Registered fake medical_questions....[OK]"
  end

####################################################################


end
