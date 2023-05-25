module Rutter
  class Client < BaseClient
    autoload :Accounting, "rutter/client/accounting"
    autoload :Common, "rutter/client/common"

    include Accounting
    include Common

    def initialize(api_base_url: nil, client_id: nil, client_secret: nil, headers: {})
      api_base_url ||= Rutter.api_base_url
      encoded_api_key = Base64.encode64("#{client_id}:#{client_secret}").gsub(/\n/, '')
      super(api_base_url: api_base_url, headers: headers.merge(default_headers(encoded_api_key)))
    end

    def inspect
      %Q(#<Rutter::Client:0x#{"%016X" % object_id}>)
    end

    private

    def default_headers(encoded_api_key)
      {
        "User-Agent" => "Rutter v#{Rutter::VERSION}",
        "Content-Type" => "application/json",
        "Authorization" => "Basic #{encoded_api_key}"
      }
    end
  end
end
