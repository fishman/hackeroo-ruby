require 'hackeroo/error/client_error'

module Hackeroo
  class Error
    # Raised when Hackeroo returns the HTTP status code 401
    class Unauthorized < Hackeroo::Error::ClientError
      HTTP_STATUS_CODE = 401
    end
  end
end
