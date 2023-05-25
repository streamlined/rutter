module Rutter
  class Error < StandardError
    ClientError           = Class.new(self)
    ServerError           = Class.new(self)

    BadRequest            = Class.new(ClientError)
    Unauthorized          = Class.new(ClientError)
    Forbidden             = Class.new(ClientError)
    Conflict              = Class.new(ClientError)
    RequestEntityTooLarge = Class.new(ClientError)
    NotFound              = Class.new(ClientError)
    NotAcceptable         = Class.new(ClientError)
    UnprocessableEntity   = Class.new(ClientError)
    TooManyRequests       = Class.new(ClientError)

    InternalServerError   = Class.new(ServerError)
    BadGateway            = Class.new(ServerError)
    ServiceUnavailable    = Class.new(ServerError)
    GatewayTimeout        = Class.new(ServerError)

    attr_reader :error_type
    attr_reader :error_message
    attr_reader :error_code

    def initialize(
      status_code: 500,
      error: "Something went wrong with communication with Rutter API.",
      error_type: "API error",
      error_code: 500,
      error_message: nil
    )
      super
      @status_code = status_code
      @error = error
      @error_type = error_type
      @error_code = error_code
      @error_message = error_message
    end

    def self.from_response(status, body, _headers)
      parsed_error = parse_error(body)
      status_code = parsed_error.dig(:status_code)
      error = parsed_error.dig(:error)
      error_type = parsed_error.dig(:error_type)
      error_message = parsed_error.dig(:error_message)
      error_code = parsed_error.dig(:error_code)
      error = error_class(status_code)&.new(
        status_code: status_code,
        error: error,
        error_type: error_type,
        error_message: error_message,
        error_code: error_code,
      )
      error ||= ClientError.new(
        status_code: status_code,
        error: error,
        error_type: error_type,
        error_message: error_message,
        error_code: error_code,
      )
      error
    end

    def self.parse_error(body)
      {
        status_code: body.dig("status_code"),
        error: body.dig("error"),
        error_type: body.dig("error_type"),
        error_message: body.dig("error_message"),
        error_code: body.dig("error_code")
      }
    end

    def self.error_class(status)
      ERRORS[status]
    end
  end

  ERRORS = {
    400 => Error::BadRequest, # invalid_parameters_error, malformed_request_error
    401 => Error::Unauthorized, # invalid_api_key_error
    403 => Error::Forbidden, # private_feature_error, insufficient_permissions_error, environment_mismatch_error
    404 => Error::NotFound, # object_not_found_error, api_method_not_found_error
    406 => Error::NotAcceptable,
    409 => Error::Conflict, # invalid_operation_error, idempotency_conflict_error
    413 => Error::RequestEntityTooLarge,
    422 => Error::UnprocessableEntity, # idempotency_unprocessable_error
    429 => Error::TooManyRequests, # rate_limited_error
    500 => Error::InternalServerError, # internal_server_error
    502 => Error::BadGateway,
    503 => Error::ServiceUnavailable,
    504 => Error::GatewayTimeout
  }.freeze
end
