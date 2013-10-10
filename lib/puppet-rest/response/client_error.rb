module PuppetRestClient
  module Response
    class ClientError < Faraday::Response::Middleware

      def on_complete(env)
        case env[:status].to_i
          when 400
            raise PuppetRestClient::Error::BadRequest.new(error(env[:body]), env[:request_headers])
          when 401
            raise PuppetRestClient::Error::Unauthorized.new(error(env[:body]), env[:request_headers])
          when 403
            raise PuppetRestClient::Error::Forbidden.new(error(env[:body]), env[:request_headers])
          when 404
            raise PuppetRestClient::Error::NotFound.new(error(env[:body]), env[:request_headers])
          when 406
            raise PuppetRestClient::Error::NotAcceptable.new(error(env[:body]), env[:request_headers])
          when 409
            raise PuppetRestClient::Error::Conflict.new(error(env[:body]), env[:request_headers])
        end
      end

      def error(body)
        if body.kind_of?(String)
          body
        elsif body['error'].kind_of?(Array)
          body['error'].join(',')
        else
          body['error']
        end
      end
    end
  end
end