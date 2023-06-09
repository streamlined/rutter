module Rutter
  class BaseClient

    def initialize(api_base_url:, headers: )
      @conn = Faraday.new(url: api_base_url, headers: headers) do |conn|
        conn.request :json
        conn.response :json

        if Rutter.debug_logger
          conn.request :curl, Rutter.debug_logger, :debug
          conn.response :logger, Rutter.debug_logger
        end

        conn.adapter Faraday.default_adapter
      end
    end

    Faraday::Connection::METHODS.each do |method|
      define_method(method) do |url, args = {}, &block|
        begin
          response = @conn.__send__(method, url, args)
        rescue Faraday::ClientError, Faraday::ServerError, Faraday::ParsingError => e
          response = e.response
        end

        payload = handle_response(response)

        block.call(payload, response.headers) if block

        payload
      end
    end

    def handle_response(response)
      case response.status
      when 200..299
        response.body
      else
        Error.from_response(response.status, response.body, response.headers)
      end
    end
  end
end
