module PuppetRestClient::PE
  extend PuppetRestClient::PE::Config

  class << self
    # Convenience alias for PuppetRestClient::DbConnection.new
    #
    # return [PuppetRestClient::DbConnection]
    def new(options=Mash.new)
      PuppetRestClient::PE::Connection.new(options)
    end

    # Delegate methods to PuppetRestClient::Connection
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end

    def read_key_file(path)
      key_file_path = File.expand_path(path)

      begin
        raw_key = File.read(key_file_path).strip
      rescue SystemCallError, IOError => e
        raise IOError, "Unable to read #{key_file_path}"
      end

      begin_rsa = '-----BEGIN RSA PRIVATE KEY-----'
      end_rsa   = '-----END RSA PRIVATE KEY-----'

      unless (raw_key =~ /\A#{begin_rsa}$/) && (raw_key =~ /^#{end_rsa}\Z/)
        msg = "The file #{key_file_path} is not a properly formatted private key.\n"
        msg << "It must contain '#{begin_rsa}' and '#{end_rsa}'"
        raise ArgumentError, msg
      end
      return OpenSSL::PKey::RSA.new(raw_key)
    end
  end
end