require 'hackeroo/error/server_error'

module Hackeroo
  class Error
    # Raised when Hackeroo returns the HTTP status code 504
    class GatewayTimeout < Hackeroo::Error::ServerError
      HTTP_STATUS_CODE = 504
      MESSAGE = "The Hackeroo servers are up, but the request couldn't be serviced due to some failure within our stack. Try again later."
    end
  end
end
