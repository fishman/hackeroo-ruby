require 'hackeroo/error'

module Hackeroo
  class Error
    # Raised when JSON parsing fails
    class DecodeError < Hackeroo::Error
    end
  end
end
