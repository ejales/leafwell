class Patient < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :symptoms
  has_and_belongs_to_many :medical_conditions
  has_many :medical_answers, dependent: :destroy

  accepts_nested_attributes_for :medical_answers, allow_destroy: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :insurance_provider, presence: true
  validates :symptoms, length: { minimum: 1, message: "must have at least one" }, if: -> { User.required_for_step?('set_symptom', form_step) }
  validates :medical_conditions, length: { minimum: 1, message: "must have at least one" }, if: -> { User.required_for_step?('set_medical_condition', form_step) }
  validates_associated :medical_answers, if: -> { User.required_for_step?('set_medical_answer', form_step) }

  attr_accessor :form_step

  def self.icon
    'fa fa-id-badge'
  end

  def full_name
    "#{first_name.capitalize unless first_name.nil?} #{last_name.capitalize unless last_name.nil?}"
  end

  def form_step
    @form_step ||= 'sign_up'
  end
  
end