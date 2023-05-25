module Rutter
  class Client
    module Common # common API
      def get_exchange_token(body: {})
        post("/item/public_token/exchange", body)
      end

      def get_connections
        get("/connections")
      end

      def get_connection(access_token:)
        get("/connections/access_token?access_token=#{access_token}")
      end

      def create_connection(access_token:, body: {})
        post("/connections?access_token=#{access_token}", body)
      end

      def get_connection_status(access_token:)
        get("/connections/status?access_token=#{access_token}")
      end
    end
  end
end
