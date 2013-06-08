require 'hackeroo/error/client_error'

module Hackeroo
  class Error
    # Raised when Hackeroo returns the HTTP status code 406
    class NotAcceptable < Hackeroo::Error::ClientError
      HTTP_STATUS_CODE = 406
    end
  end
end
