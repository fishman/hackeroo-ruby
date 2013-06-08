require 'hackeroo/error/server_error'

module Hackeroo
  class Error
    # Raised when Hackeroo returns the HTTP status code 502
    class BadGateway < Hackeroo::Error::ServerError
      HTTP_STATUS_CODE = 502
      MESSAGE = "Hackeroo is down or being upgraded."
    end
  end
end
