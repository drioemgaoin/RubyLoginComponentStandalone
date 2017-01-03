module LoginHelper
  def display_provider_name provider
    mappings = {
      facebook: 'facebook',
      google_oauth2: 'google'
    }

    mappings[provider]
  end
end
