class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_filter :ensure_signup_complete
  before_action :authenticate_user!

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation) do |u|
        u.permit(:username,:validate_username, :password,:password_confirmation, :invitation_token)
      end

      devise_parameter_sanitizer.permit(:invite) do |u|
        u.permit(:name,:comments)
      end

      devise_parameter_sanitizer.permit(:sign_up) do |u|
        u.permit(:username,:password,:password_confirmation)
      end

      devise_parameter_sanitizer.permit(:sign_in) do |u|
        u.permit(:username,:email,:password,:password_confirmation,:phone, :validate_username, :avatar_cache, :remove_avatar, :current_password,:remember_me)
      end

      devise_parameter_sanitizer.permit(:account_update) do |u|
        u.permit(:username,:email,:password,:password_confirmation,:phone, :validate_username,:avatar, :avatar_cache, :remove_avatar, :current_password)
      end
    end
end
