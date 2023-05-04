class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :set_configurations

  private

  def set_configurations
    @app_name = "Leafwell"
    @app_description = "Second Round"
    @app_icon = "fas fa-cannabis"
  end
end
