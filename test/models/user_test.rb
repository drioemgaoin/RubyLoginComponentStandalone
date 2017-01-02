require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider => 'facebook',
      :uid => '123545',
      :info => {
        'name' => 'Second user',
        'email' => 'seconduseremail@domain.com'
      },
      :extra => {
        'raw_info' => {
          'name' => 'Second User'
        }
      },
      :credentials => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    })
  end

  test "should not create the new user if his email is already used by another one" do
    user = User.find_for_oauth(OmniAuth.config.mock_auth[:facebook])
    assert user
  end
end
