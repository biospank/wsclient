module Api::WorkShare

  DEFAULT_BASE_URL = "https://my.workshare.com/api/open-v1.0"

  class Session

    def initialize(key, secret, ss = nil)
      @key = key
      @secret = secret
      @serialized_session = ss if ss && ss['authorized']
    end

    def authorize()
      begin
        response = RestClient.get make_uri("user_sessions.json"), {
          :params => {
            "user_session[email]" => @key,
            "user_session[password]" => @secret,
            "device[app_uid]" => ENV['WORKSHARE_APP_UID']
          },
          :accept => :json
        }

        @serialized_session = response.cookies.merge({
          "consumer_key" => @key,
          "consumer_secret" => @secret,
          "authorized" => true
        })

      rescue => e
        logger.error("Authentication error: #{e.response}")
        return false
      end

      return true

    end

    def dump_session()
      @serialized_session.to_yaml
    end

    def authorized?
      @serialized_session && @serialized_session["device_credentials"]
    end

    def self.restore(data)
      serialized_session = YAML.load(StringIO.new(data))
      return self.new(serialized_session["consumer_key"], serialized_session["consumer_secret"], serialized_session)
    end

  end

end
