class UsersController < ApplicationController
  def current_user_home
    @user = current_user

    if @user.patient
      if @user.patient.symptoms.empty?
        redirect_to onboarding_patient_path('set_symptom')
      elsif @user.patient.medical_conditions.empty?
        redirect_to onboarding_patient_path('set_medical_condition')
      elsif @user.patient.medical_answers.empty?
        redirect_to onboarding_patient_path('set_medical_answer')
      else
        redirect_to patient_path(@user.patient)
      end
    else
      redirect_to onboarding_patient_path('set_patient')
    end
  end
end
