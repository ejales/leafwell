Rails.application.routes.draw do
  authenticated :user, ->(user) { user.admin? } do
    ActiveAdmin.routes(self)
    get '/', to: redirect('/admin')
  end
  resources :patients, only: [:show]
  resources :onboarding_patient, only: [:show, :update]
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'users#current_user_home'
end
