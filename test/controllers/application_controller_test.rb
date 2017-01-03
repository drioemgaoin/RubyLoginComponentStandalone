require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
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
  end

  test "should redirect the user to the finish signup page if he hasn't confirmed his email" do
    log_in()
    confirm_email(:john, "")

    get '/'
    assert_redirected_to finish_signup_path(assigns(:current_user))
  end

  test "should redirect the user to the home page if he has confirmed his email" do
    log_in()
    confirm_email(:john, "johndoe@domain.com")

    get '/'
    assert :success
  end
end