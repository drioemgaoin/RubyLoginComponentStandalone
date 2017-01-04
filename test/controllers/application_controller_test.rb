require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:user_unconfirmed)
  end

  def teardown
    sign_out users(:user_unconfirmed)
  end

  test "should redirect the user to the finish signup page if he hasn't confirmed his email" do
    confirm_email(:user_unconfirmed, "")

    get '/'
    assert_redirected_to finish_signup_path(assigns(:current_user))
  end

  test "should redirect the user to the home page if he has confirmed his email" do
    confirm_email(:user_unconfirmed, "confirm_email@domain.com")

    get '/'
    assert :success
  end
end
