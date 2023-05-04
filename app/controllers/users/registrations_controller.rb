class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def configure_sign_up_params
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :username, :password, :password_confirmation, :current_password])
  end

  # The path used after sign up.
  def after_sign_up_path_for(_resource)
    onboarding_patient_path('set_patient')
  end
end