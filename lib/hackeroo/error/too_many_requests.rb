require 'hackeroo/error/client_error'

module Hackeroo
  class Error
    # Raised when Hackeroo returns the HTTP status code 429
    class TooManyRequests < Hackeroo::Error::ClientError
      HTTP_STATUS_CODE = 429
    end
    EnhanceYourCalm = TooManyRequests
    RateLimited = TooManyRequests
  end
end
