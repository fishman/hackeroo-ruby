require 'hackeroo/error/server_error'

module Hackeroo
  class Error
    # Raised when Hackeroo returns the HTTP status code 500
    class InternalServerError < Hackeroo::Error::ServerError
      HTTP_STATUS_CODE = 500
      MESSAGE = "Something is technically wrong."
    end
  end
end
