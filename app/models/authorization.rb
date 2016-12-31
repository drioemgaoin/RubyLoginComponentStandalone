class Authorization < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  scope :facebook, lambda { find_by(provider: 'facebook') }
  # after_create :fetch_details

  def fetch_details
    self.send("fetch_details_from_#{self.provider.downcase}")
  end

  def fetch_details_from_facebook
    graph = Koala::Facebook::API.new(self.token)
    profile = graph.get_object("me")
    user = self.user

    pust "AAAAHHHHHHHHHHH"
    puts profile
    user.update_attributes(first_name: profile['first_name'], last_name: profile['last_name'],
                            address: profile["location"]["name"])

    user.save
  end

  def fetch_details_from_google_oauth2
  end

end
