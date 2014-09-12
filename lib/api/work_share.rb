module Api
  module WorkShare

    DEFAULT_BASE_URL = "https://my.workshare.com/api/"

    module V1

      VERSION_PATH = "open-v1.0/"

      class Session

        def initialize(key, secret, ss = nil)
          @key = key
          @secret = secret
          @serialized_session = ss
          
        end

        def authorize()
          begin
            response = Faraday.post(
              make_uri("user_sessions.json"),
              "user_session[email]" => @key,
              "user_session[password]" => @secret,
              "device[app_uid]" => ENV['WORKSHARE_APP_UID']
            )
            
            @serialized_session = JSON.parse(response.env[:body]).merge({
              "consumer_key" => @key,
              "consumer_secret" => @secret
            })

          rescue => e
            return false
          end

          return true

        end

        def dump_session()
          @serialized_session.to_yaml
        end

        def authorized?
          return (!@serialized_session.nil? && 
            !@serialized_session["device_auth_token"].blank?)
        end

        def self.restore(data)
          serialized_session = YAML.load(StringIO.new(data))
          return self.new(serialized_session["consumer_key"], serialized_session["consumer_secret"], serialized_session)
        end
        
        private
        
        def make_uri(resource)
          DEFAULT_BASE_URL + VERSION_PATH + resource
        end
      end
    end
  end

end
