module PuppetDbRestClient
  class Connection
    include PuppetDbRestClient::Connection::Nodes
    include PuppetDbRestClient::Connection::FactNames
    include PuppetDbRestClient::Connection::Facts
    include PuppetDbRestClient::Connection::Resources
    include PuppetDbRestClient::Request
    #include PuppetDbRestClient::Authentication

    # @private

    Config::VALID_OPTIONS_KEYS.each do |key|
      attr_accessor key
    end

    def initialize(attrs=Mash.new)
      attrs = PuppetDbRestClient.options.merge(attrs)

      #unless attrs[:client_key].is_a?(OpenSSL::PKey::RSA)
      #  attrs[:client_key] = OpenSSL::PKey::RSA.new(attrs[:client_key])
      #end

      Config::VALID_OPTIONS_KEYS.each do |key|
        instance_variable_set("@#{key}".to_sym, attrs[key])
      end
    end

  end
end