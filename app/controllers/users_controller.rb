class UsersController < ActionController::Base
  protect_from_forgery with: :exception

  def finish_signup
    if request.patch? && params[:user]
      if current_user.update(user_params)
        current_user.skip_reconfirmation! if current_user.respond_to?(:skip_reconfirmation)
        bypass_sign_in(current_user)
        redirect_to root_url, notice: 'Your profile was successfully updated.'
        return
      end
    end

    render "finish_signup", :layout => "application"
  end

  private
    def user_params
      accessible = [ :name, :email ]
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end
end
