class OnboardingPatientController < ApplicationController
  include Wicked::Wizard
  
  steps(*User.form_steps)

  def show
    @user = current_user

    case step
    when 'sign_up'
      skip_step if @user.persisted?
    when 'set_patient'
      @patient = @user.patient || @user.build_patient
    when 'set_symptom'
      @symptoms = Symptom.all
      @patient = @user.patient
      @symptom = @patient.symptoms.presence
    when 'set_medical_condition'
      @mis = MedicalCondition.all
      @patient = @user.patient
      @mi = @patient.medical_conditions.presence
    when 'set_medical_answer'
      @patient = @user.patient
      @mqs = @patient.medical_conditions.flat_map(&:medical_questions)

      # Delete medical_answers if there is a change in medical_condition
      if @patient.medical_answers
        @patient.medical_answers.where.not(medical_question_id: @mqs.pluck(:id)).delete_all
      end
      
      # Build if object does not exist
      @mqs.each do |mq|
        @patient.medical_answers.build(medical_question_id: mq.id) unless @patient.medical_answers.where(medical_question_id: mq.id, patient_id: @patient.id).first
      end
    end

    render_wizard
  end

  def update
    @user = current_user
    @patient = @user.patient
    
    case step
    when 'set_patient'
      if @user.update(onboarding_params(step).except(:form_step))
        render_wizard @user.patient
      else
        render_wizard @user.patient, status: :unprocessable_entity
      end
    when 'set_symptom'
      @symptoms = Symptom.all
      if @user.patient.update(onboarding_params(step))
        render_wizard @user.patient
      else
        render_wizard @user.patient, status: :unprocessable_entity
      end
    when 'set_medical_condition'
      @mis = MedicalCondition.all
      @mqs = @user.patient.medical_conditions.flat_map(&:medical_questions)
      if @user.patient.update(onboarding_params(step))
        render_wizard @user.patient
      else
        render_wizard @user.patient, status: :unprocessable_entity
      end
    when 'set_medical_answer'
      if @user.patient.update(onboarding_params(step))
        render_wizard @user.patient
      else
        render_wizard @user.patient, status: :unprocessable_entity
      end
    end
  end

  private

  def finish_wizard_path
    patient_path(current_user.patient)
  end

  def onboarding_params(step = 'sign_up')
    permitted_attributes = case step
                           when 'set_patient'
                             required_parameters = :user
                             [patient_attributes: [:id, :_destroy, :first_name, :last_name, :date_of_birth, :gender, :phone_number, :insurance_provider, :fitness_activity, :address, :country, :state, :city, :zip_code]]
                           when 'set_symptom'
                             required_parameters = :patient
                             [symptom_ids: []]
                           when 'set_medical_condition'
                             required_parameters = :patient
                             [medical_condition_ids: []]
                           when 'set_medical_answer'
                             required_parameters = :patient
                             [medical_answers_attributes: [:id, :_destroy, :medical_question_id, :value]]
                           end
    params.require(required_parameters).permit(:id, permitted_attributes).merge(form_step: step)
  end
end