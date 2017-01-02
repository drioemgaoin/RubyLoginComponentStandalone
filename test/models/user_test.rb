require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @facebook_response = OmniAuth::AuthHash.new({
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
    OmniAuth.config.mock_auth[:facebook] = @facebook_response
  end

  test "should create a new user" do
    user_count = User.count

    user = User.find_for_oauth(@facebook_response)
    assert_not_nil user
    assert_equal((user_count + 1), User.count)
    assert_equal(User, user.class)
  end

  test "should find and return an existing user" do
    user = User.find_for_oauth(@facebook_response)
    user_count = User.count

    user = User.find_for_oauth(@facebook_response)
    assert_not_nil user
    assert_equal(user_count, User.count)
    assert_equal(User, user.class)
  end

  test "should create user with a temporary email if the the provider doesn't gives us a verified email" do
    user = User.find_for_oauth(@facebook_response)
    assert_not_nil user
    assert_equal("change@me-123456789-facebook.com", user.email)
  end

  test "should get the existing user by email if the provider gives us a verified email" do
    @facebook_response.info.verified = true;

    user = User.find_for_oauth(@facebook_response)
    assert_not_nil user
    assert_equal("john@company_name.com", user.email)
  end

  test "should set the identity with the user if they are different" do
    user = User.find_for_oauth(@facebook_response)
    assert_not_nil user
    assert_equal(Identity.find_for_oauth(@facebook_response).user, user)
  end
end
