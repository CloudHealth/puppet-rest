module PuppetDbRestClient
  module Response
    class ClientError < Faraday::Response::Middleware

      def on_complete(env)
        case env[:status].to_i
          when 400
            raise PuppetDbRestClient::Error::BadRequest.new(error(env[:body]), env[:request_headers])
          when 401
            raise PuppetDbRestClient::Error::Unauthorized.new(error(env[:body]), env[:request_headers])
          when 403
            raise PuppetDbRestClient::Error::Forbidden.new(error(env[:body]), env[:request_headers])
          when 404
            raise PuppetDbRestClient::Error::NotFound.new(error(env[:body]), env[:request_headers])
          when 406
            raise PuppetDbRestClient::Error::NotAcceptable.new(error(env[:body]), env[:request_headers])
          when 409
            raise PuppetDbRestClient::Error::Conflict.new(error(env[:body]), env[:request_headers])
        end
      end

      def error(body)
        if body['error'].kind_of?(Array)
          body['error'].join(',')
        else
          body['error']
        end
      end

    end
  end
end