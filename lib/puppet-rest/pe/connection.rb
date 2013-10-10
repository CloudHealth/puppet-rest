module PuppetRestClient::PE
  class Connection
    include PuppetRestClient::PE::Connection::Node
    include PuppetRestClient::PE::Connection::Catalog
    include PuppetRestClient::PE::Request

    Config::VALID_OPTIONS_KEYS.each do |key|
      attr_accessor key
    end

    def initialize(attrs=Mash.new)
      attrs = PuppetRestClient::PE.options.merge(attrs)

      #unless attrs[:client_key].is_a?(OpenSSL::PKey::RSA)
      #  attrs[:client_key] = OpenSSL::PKey::RSA.new(attrs[:client_key])
      #end

      PuppetRestClient::PE::Config::VALID_OPTIONS_KEYS.each do |key|
        instance_variable_set("@#{key}".to_sym, attrs[key])
      end
    end

  end
end