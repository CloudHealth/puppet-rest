module PuppetRestClient
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

  class Error::BadRequest < PuppetRestClient::Error
  end

  class Error::Unauthorized < PuppetRestClient::Error
  end

  class Error::Forbidden < PuppetRestClient::Error
  end

  class Error::NotFound < PuppetRestClient::Error
  end

  class Error::NotAcceptable < PuppetRestClient::Error
  end

  class Error::Conflict < PuppetRestClient::Error
  end

  class Error::ClientError < PuppetRestClient::Error
  end

end