module Oauth
  class Base
    attr_reader :provider, :data, :access_token, :uid

    def initialize(params, access_token)
      @provider = self.class.name.split('::').last.downcase
      #puts env['omniauth.auth']

      # prepare_oauth_params baseUri
      # puts "OAUTH PARAMS - #{@oauth_params}"
      @client = HTTPClient.new
      # @oauth_code = get_oauth_code
      # puts "OAUTH CODE IS - #{@oauth_code}"

      # prepare_params(params, baseUri)
      # puts "PARAMS - #{@params}"
      # @client = HTTPClient.new
      # @access_token = params[:access_token].presence || get_access_token
      # puts "ACCESS TOKEN IS - #{@access_token}"
      @access_token = access_token
      get_data if access_token.present?
    end

    def get_oauth_code
      url = "#{self.class::AUTHORIZE_URL}?client_id=#{@oauth_params[:client_id]}&amp;display=#{@oauth_params[:display]}&amp;redirect_uri=#{@oauth_params[:redirect_uri]}&amp;response_type=#{@oauth_params[:response_type]}&amp;scope=#{@oauth_params[:scope]}"
      puts url
      response = @client.get(url)
      # puts "AUTHORIZATION CODE RESPONSE - #{response.body}"
      # JSON.parse(response.body)["code"]
    end

    def get_access_token
      response = @client.post(self.class::ACCESS_TOKEN_URL, @params)
      puts "ACCESS TOKEN RESPONSE - #{response.body}"
      JSON.parse(response.body)["access_token"]
    end

    def prepare_oauth_params baseUri

      # client_id:212322639214701
      # display:popup
      # redirect_uri:http://localhost:7000/auth/facebook/callback
      # response_type:code
      # scope:email
      # state:726ea616b5146e369f1d624f41030c9b568512abc248798f

      @oauth_params = {
        client_id:      ENV["#{@provider.upcase}_KEY"],
        display:        'popup',
        redirect_uri:   'http://localhost:7000/auth/facebook/callback',
        response_type:  'code',
        scope:          'email',
        state:          ''
      }
    end

    def prepare_params(params, baseUri)
      @params = {
        code:          params[:code],
        redirect_uri:  baseUri + "/" + params[:redirectUri],
        client_id:     ENV["#{@provider.upcase}_KEY"],
        client_secret: ENV["#{@provider.upcase}_SECRET"],
        grant_type:    'authorization_code'
      }
    end

    def authorized?
      @access_token.present?
    end

  end

end
