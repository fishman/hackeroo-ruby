require 'forwardable'
require 'hackeroo/error/configuration_error'

module Hackeroo
  module Configurable
    extend Forwardable
    attr_accessor :clientkey, :endpoint, :connection_options, :identity_map, :middleware
    def_delegator :options, :hash

    class << self

      def keys
        @keys ||= [
          :clientkey,
          :endpoint,
          :connection_options,
          :identity_map,
          :middleware,
        ]
      end

    end

    # Convenience method to allow configuration options to be set in a block
    #
    # @raise [Hackeroo::Error::ConfigurationError] Error is raised when supplied
    #   hackeroo credentials are not a String or Symbol.
    def configure
      yield self
      validate_credential_type!
      self
    end

    def reset!
      Hackeroo::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Hackeroo::Default.options[key])
      end
      self
    end
    alias setup reset!

    # @return [Boolean]
    def user_token?
      !!(@oauth_token && @oauth_token_secret)
    end

    # @return [Boolean]
    def bearer_token?
      !!@bearer_token
    end

    # @return [Boolean]
    def credentials?
      credentials.values.all? || bearer_token?
    end

  private

    # @return [Hash]
    def credentials
      {
        :clientkey    => @clientkey,
      }
    end

    # @return [Hash]
    def options
      Hash[Hackeroo::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end

    # Ensures that all credentials set during configuration are of a
    # valid type. Valid types are String and Symbol.
    #
    # @raise [Hackeroo::Error::ConfigurationError] Error is raised when
    #   supplied hackeroo credentials are not a String or Symbol.
    def validate_credential_type!
      credentials.each do |credential, value|
        next if value.nil?

        unless value.is_a?(String) || value.is_a?(Symbol)
          raise(Error::ConfigurationError, "Invalid #{credential} specified: #{value} must be a string or symbol.")
        end
      end
    end

  end
end
