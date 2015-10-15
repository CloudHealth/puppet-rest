module PuppetRestClient::PE
  module Config

    # The default Chef server URL
    DEFAULT_SERVER_URL = 'http://localhost:8140'

    # The default Spice User-Agent header
    DEFAULT_USER_AGENT = "PuppetRestClient #{PuppetRestClient::VERSION}"

    # Default connection options
    DEFAULT_CONNECTION_OPTIONS = {}

    # Default client name
    DEFAULT_CLIENT_NAME = ''

    # Default key file
    DEFAULT_CLIENT_KEY = ''

    DEFAULT_ENVIRONMENT = 'production'

    DEFAULT_ACCEPT = 'pson'

    # Default puppetpe rest api version
    # v1, v2 leave blank
    # 2015.2 or greater pass in 'puppet/v3'
    DEFAULT_API_VERSION = nil

    # An array of valid config options
    VALID_OPTIONS_KEYS = [
      :server_url,
      :environment,
      :api_version,
      :client_name,
      :client_key,
      :user_agent,
      :connection_options,
      :middleware,
      :accept
    ]

    # Default middleware stack
    DEFAULT_MIDDLEWARE = Proc.new do |builder|
      builder.use PuppetRestClient::Response::ParseJSON
      builder.use PuppetRestClient::Response::ClientError
      builder.adapter Faraday.default_adapter
    end

    VALID_OPTIONS_KEYS.each do |key|
      attr_accessor key
    end

    # Reset all config options to default when the module is extended
    def self.extended(base)
      base.reset
    end # def self.extended

    # Convenience method to configure PuppetRestClient in a block
    # @example Configuring PuppetRestClient
    #   PuppetRestClient.setup do |s|
    #     s.server_url  = "http://puppetdb.example.com:8081"
    #     s.client_name = "admin"
    #     s.client_key    = PuppetRestClient.read_key_file("/path/to/key_file.pem")
    #   end
    # @yieldparam PuppetRestClient
    # @yieldreturn PuppetRestClient
    def setup
      yield self
      self
    end

    # Create an options hash from valid options keys
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k)}
      options
    end

    # Reset all config options to their defaults
    def reset
      self.user_agent         = DEFAULT_USER_AGENT
      self.environment        = DEFAULT_ENVIRONMENT
      self.api_version        = DEFAULT_API_VERSION
      self.server_url         = DEFAULT_SERVER_URL
      self.client_name        = DEFAULT_CLIENT_NAME
      self.client_key         = DEFAULT_CLIENT_KEY
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self.middleware         = DEFAULT_MIDDLEWARE
      self.accept             = DEFAULT_ACCEPT
      self
    end

  end
end