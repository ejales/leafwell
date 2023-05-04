class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :registerable

  has_one :patient, dependent: :destroy

  accepts_nested_attributes_for :patient, allow_destroy: true

  validates :username, presence: true, uniqueness: true
  validates_associated :patient, if: -> { User.required_for_step?('set_patient', form_step) }

  enum role: %i[user admin]
  
  after_initialize :set_default_role, if: :new_record?

  cattr_accessor :form_steps do
    %w[sign_up set_patient set_symptom set_medical_condition set_medical_answer]
  end

  attr_accessor :form_step

  def form_step
    @form_step ||= 'sign_up'
  end

  def self.required_for_step?(step, form_step_user)
    form_steps.index(step) == form_steps.index(form_step_user)
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
