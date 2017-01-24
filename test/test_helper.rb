ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# class CarrierWave::Mount::Mounter
#   def store!
#     # Not storing uploads in the tests
#   end
# end

class ActiveSupport::TestCase
  include ActionDispatch::TestProcess

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  OmniAuth.config.test_mode = true

  def setup
    OmniAuth.config.mock_auth[:facebook] = nil
  end

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

  def after_teardown
    super
    CarrierWave.clean_cached_files!(0)
  end
end
