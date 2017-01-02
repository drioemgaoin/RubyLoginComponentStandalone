require 'test_helper'

class IdentityTest < ActiveSupport::TestCase
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

  test "should create a new identity" do
    identity = Identity.find_for_oauth(@facebook_response)
    assert_not_nil identity
  end

  test "should find the existing identity" do
    old_identity = Identity.find_for_oauth(@facebook_response)
    assert_not_nil old_identity

    identity = Identity.find_for_oauth(@facebook_response)
    assert_not_nil identity
    assert_equal(old_identity.provider, identity.provider)
    assert_equal(old_identity.uid, identity.uid)
  end
end
