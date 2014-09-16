module Api
  module Errors
    class InternalServerError < StandardError; end
    class AuthorizationError < StandardError; end
    class NotFound < StandardError; end

    
    class WSError < Faraday::Response::Middleware
      def on_complete(env)
        # Ignore any non-error response codes
        return if (status = env[:status]) < 400
        case status
        when 404
          raise Api::Errors::NotFound
        when 401, 422
          raise Api::Errors::AuthorizationError, JSON.parse(env[:body])["errors"]
        else
          raise Api::Errors::InternalServerError # Treat any other errors as 500
        end
      end
    end
  end
end