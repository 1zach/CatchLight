class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    #This is a hacky way to fix our problem.  When logging in a user is redirected for some reason to the previous
    # users session - they're not authorized, but it's ugly
    session.fetch 'user_return_to', root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :username])

    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :username])
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
  
end
