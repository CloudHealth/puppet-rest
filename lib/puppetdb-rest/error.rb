module PuppetDbRestClient
  class Error < StandardError
    attr_reader :http_headers, :wrapped_exception

    def initialize(exception=$!, http_headers={})
      @http_headers = http_headers
      if exception.respond_to?(:backtrace)
        super(exception.message)
        @wrapped_exception = exception
      else
        super(exception.to_s)
      end
    end

    def backtrace
      @wrapped_exception ? @wrapped_exception.backtrace : super
    end

  end

  class Error::BadRequest < PuppetDbRestClient::Error
  end

  class Error::Unauthorized < PuppetDbRestClient::Error
  end

  class Error::Forbidden < PuppetDbRestClient::Error
  end

  class Error::NotFound < PuppetDbRestClient::Error
  end

  class Error::NotAcceptable < PuppetDbRestClient::Error
  end

  class Error::Conflict < PuppetDbRestClient::Error
  end

  class Error::ClientError < PuppetDbRestClient::Error
  end

end