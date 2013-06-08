require 'hackeroo/error/server_error'

module Hackeroo
  class Error
    # Raised when Hackeroo returns the HTTP status code 503
    class ServiceUnavailable < Hackeroo::Error::ServerError
      HTTP_STATUS_CODE = 503
      MESSAGE = "(__-){ Hackeroo is over capacity."
    end
  end
end
