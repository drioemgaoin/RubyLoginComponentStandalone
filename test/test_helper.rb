ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def log_in
    post '/users/auth/facebook/callback'
    follow_redirect!
  end

  def confirm_email(user, email)
    patch "/users/#{users(user).id}/finish_signup", params: { user: { email: email }}
  end

  def log_out
    delete '/users/logout'
    follow_redirect!
  end
end
