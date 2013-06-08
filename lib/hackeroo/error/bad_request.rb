require 'hackeroo/error/client_error'

module Hackeroo
  class Error
    # Raised when Hackeroo returns the HTTP status code 400
    class BadRequest < Hackeroo::Error::ClientError
      HTTP_STATUS_CODE = 400
    end
  end
end
