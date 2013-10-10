module PuppetRestClient::DB
  class Connection
    include PuppetRestClient::DB::Connection::Nodes
    include PuppetRestClient::DB::Connection::FactNames
    include PuppetRestClient::DB::Connection::Facts
    include PuppetRestClient::DB::Connection::Resources
    include PuppetRestClient::DB::Request

    Config::VALID_OPTIONS_KEYS.each do |key|
      attr_accessor key
    end

    def initialize(attrs=Mash.new)
      attrs = PuppetRestClient::DB.options.merge(attrs)

      #unless attrs[:client_key].is_a?(OpenSSL::PKey::RSA)
      #  attrs[:client_key] = OpenSSL::PKey::RSA.new(attrs[:client_key])
      #end

      PuppetRestClient::DB::Config::VALID_OPTIONS_KEYS.each do |key|
        instance_variable_set("@#{key}".to_sym, attrs[key])
      end
    end

  end
end