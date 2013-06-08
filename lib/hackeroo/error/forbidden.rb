require 'hackeroo/error/client_error'

module Hackeroo
  class Error
    # Raised when Hackeroo returns the HTTP status code 403
    class Forbidden < Hackeroo::Error::ClientError
      HTTP_STATUS_CODE = 403
    end
  end
end
