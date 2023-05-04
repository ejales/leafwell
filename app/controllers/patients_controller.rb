class PatientsController < ApplicationController
  before_action :set_patient, only: :show

  # GET /patients/1 or /patients/1.json
  def show
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = Patient.find(params[:id])
  end
end
