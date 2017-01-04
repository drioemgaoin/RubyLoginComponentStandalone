require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:user_unconfirmed)
  end

  def teardown
    sign_out users(:user_unconfirmed)
  end

  test "should redirect to root_url if user confirmed his an unexisting one" do
    confirm_email(:user_unconfirmed, "confirm_email@domain.com")
    assert_redirected_to root_url
  end

  test "should show errors if user didn't confirm his email" do
    confirm_email(:user_unconfirmed, "")
    assert :success
  end
end
