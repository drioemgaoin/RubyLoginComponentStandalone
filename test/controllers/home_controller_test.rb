require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  include Devise::Test::IntegrationHelpers

  test "should redirect the user to the login page if not authenticated" do
    get '/'
    assert_redirected_to new_user_session_path
  end

  test "should redirect the user to the index page if authenticated" do
    sign_in users(:user_confirmed)

    get '/'
    assert_response :success
  end
end
