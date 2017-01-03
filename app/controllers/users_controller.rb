class UsersController < ActionController::Base
  before_action :set_user, only: [:destroy, :finish_signup]

  def finish_signup
    if request.patch? && params[:user]
      if @user.update(user_params)
        @user.skip_reconfirmation! if @user.respond_to?(:skip_reconfirmation)
        bypass_sign_in(@user)
        redirect_to root_url, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      accessible = [ :name, :email ]
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end
end
