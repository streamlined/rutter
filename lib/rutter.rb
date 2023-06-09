require "rutter/version"
require "faraday"
require "faraday_middleware"
require "faraday_curl"

require_relative "rutter/version"

module Rutter
  autoload :BaseClient, "rutter/base_client"
  autoload :Client, "rutter/client"
  autoload :Types, "rutter/types"
  autoload :Error, "rutter/error"

  @api_base_url = "https://production.rutterapi.com"

  class << self
  attr_accessor :api_base_url, :client_id, :client_secret, :debug_logger

    def client
      @client ||= Client.new(
        api_base_url: Rutter.api_base_url,
        client_id: client_id,
        client_secret: client_secret
      )
    end
  end
end
