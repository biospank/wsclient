module Api
  module WorkShare

    DEFAULT_BASE_URL = "https://my.workshare.com/api/"
    
    class AuthorizationError < StandardError; end

    module V1

      VERSION_PATH = "open-v1.0"

      class Session

        def initialize(key, secret, ss = nil)
          @key = key
          @secret = secret
          @serialized_session = ss
          
          @conn = Faraday.new(:url => (DEFAULT_BASE_URL + VERSION_PATH)) do |builder|
            builder.use :cookie_jar
#            builder.response :logger
#            builder.use Faraday::Response::RaiseError
            builder.use     Errors::WSError       # Include custom middleware
            builder.adapter  Faraday.default_adapter
          end
          
        end

        def authorize()
          begin
            response = @conn.post do |req|
              req.url '/user_sessions.json'
              req.params["user_session[email]"] = @key
              req.params["user_session[password]"] = @secret
            end
            
            @serialized_session = JSON.parse(response.body).merge({
              "consumer_key" => @key,
              "consumer_secret" => @secret
            })

          rescue Api::Errors::AuthorizationError
            raise
          rescue Faraday::ClientError => ce
            raise
          end

          return true

        end
        
        def logout()
          begin
            response = @conn.get do |req|
              req.url '/logout.json'
            end
          
          rescue ce
            raise
          end

          return true
          
        end
        
        def all_files()
          response = nil
          
          begin
            response = @conn.get do |req|
              req.url '/files.json'
            end

          rescue Api::Errors::AuthorizationError
            raise
          end
          
          return JSON.parse(response.body)["decks"]

        end

        def dump_session()
          @serialized_session.to_yaml
        end

        def authorized?
          return (!@serialized_session.nil? && !@serialized_session["is_unknown_user"].nil?)
        end

        def self.restore(data)
          serialized_session = YAML.load(StringIO.new(data))
          new_session = self.new(serialized_session["consumer_key"], serialized_session["consumer_secret"], serialized_session)
          new_session.authorize
          new_session
        end
        
      end
    end
  end

end
