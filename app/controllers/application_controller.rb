class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def authenticate_user!
    unauthorized! unless current_user
  end

  def unauthorized!
    head :unauthorized
  end

  def current_user
    @current_user
  end

  def set_current_user
    token = request.headers['Authorization'].to_s.split(' ').last
    return unless token

    payload = Token.new(token)

    @current_user = User.find(payload.user_id) if payload.valid?
  end
end
