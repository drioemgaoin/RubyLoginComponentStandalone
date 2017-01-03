require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  def setup
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider => "facebook",
      :uid => "123456789",
      :info => {
        :name => "John Doe",
        :email => "john@company_name.com",
        :first_name => "John",
        :last_name => "Doe",
        :image => "http://graph.facebook.com/v2.6/123456789/picture"
      },
      :credentials => {
        :token => "token",
        :refresh_token => "another_token",
        :expires_at => 1354920555,
        :expires => true
      },
      :extra => {
        :raw_info => {
          :sub => "123456789",
          :email => "user@domain.example.com",
          :email_verified => true,
          :name => "John Doe",
          :given_name => "John",
          :family_name => "Doe",
          :image => "https://lh3.googleusercontent.com/url/photo.jpg",
          :gender => "male",
          :birthday => "0000-06-25",
          :locale => "en",
          :hd => "company_name.com"
        }
      }
    })

    post '/users/auth/facebook/callback'
    follow_redirect!
  end

  def teardown
    current_user = assigns(:current_user)
    if !current_user.nil?
      puts 'LOG OUT ------'
      delete '/users/logout'
      follow_redirect!
    end
  end

  test "should redirect to root_url if user confirmed his email" do
    patch "/users/#{users(:john).id}/finish_signup", params: { user: { email: "johndoe@domain.com" }}
    assert_redirected_to root_url
  end

  test "should show errors if user didn't confirm his email" do
    patch "/users/#{users(:john).id}/finish_signup", params: { user: { email: '' }}
    assert :success
    assert_not_nil assigns(:show_errors)
  end

  test "should destroy user" do
    patch "/users/#{users(:john).id}/finish_signup", params: { user: { email: "johndoe@domain.com" }}

    delete '/users/logout'
    assert_redirected_to root_url
  end
end
