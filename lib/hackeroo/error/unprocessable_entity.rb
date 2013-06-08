require 'hackeroo/error/client_error'

module Hackeroo
  class Error
    # Raised when Hackeroo returns the HTTP status code 404
    class UnprocessableEntity < Hackeroo::Error::ClientError
      HTTP_STATUS_CODE = 422
    end
  end
end
