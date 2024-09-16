class ApplicationController < ActionController::Base
  # Hacks to work around Gitpod/SSL issue:
  # We'll override Devise's current_user method.
  # We'll always be signed in as alice.
  # Make sure you run `rails sample_data`
  # Delete this code when the issue is resolved.

  # helper_method :current_user

  # def current_user
  #   @alice ||= User.find_by! username: "alice"
  # end

  # skip_forgery_protection
  
  # End hacks.
  ##############################################################################
  
  before_action :authenticate_user!

  include Pundit::Authorization
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized 

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :private, :name, :bio, :website, :avatar_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :private, :name, :bio, :website, :avatar_image])
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    
    redirect_back(fallback_location: root_url)
  end
end
