module Hackeroo
  # Custom error class for rescuing from all Hackeroo errors
  class Error < StandardError
    attr_reader :rate_limit, :wrapped_exception

    # @return [Hash]
    def self.errors
      @errors ||= Hash[descendants.map{|klass| [klass.const_get(:HTTP_STATUS_CODE), klass]}]
    end

    # @return [Array]
    def self.descendants
      ObjectSpace.each_object(::Class).select{|klass| klass < self}
    end

    # Initializes a new Error object
    #
    # @param exception [Exception, String]
    # @param response_headers [Hash]
    # @return [Hackeroo::Error]
    def initialize(exception=$!, response_headers={})
      @rate_limit = Hackeroo::RateLimit.new(response_headers)
      @wrapped_exception = exception
      exception.respond_to?(:backtrace) ? super(exception.message) : super(exception.to_s)
    end

    def backtrace
      @wrapped_exception.respond_to?(:backtrace) ? @wrapped_exception.backtrace : super
    end

  end
end
