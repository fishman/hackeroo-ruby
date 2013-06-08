require 'hackeroo/error/client_error'

module Hackeroo
  class Error
    # Raised when Hackeroo returns the HTTP status code 404
    class NotFound < Hackeroo::Error::ClientError
      HTTP_STATUS_CODE = 404
    end
  end
end
