Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
  {
    display: 'popup',
    secure_image_url: 'true',
    image_size: 'square',
    client_options: {
      ssl: {
        ca_file: Rails.root.join('lib', 'assets', 'cacert.pem').to_s
      }
    }
  }
end
