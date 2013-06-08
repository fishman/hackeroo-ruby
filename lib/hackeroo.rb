require 'hackeroo/default'
require 'hackeroo/client'
require 'hackeroo/configurable'
require 'hackeroo/rate_limit'
require 'hackeroo/performance'
require 'hackeroo/cursor'

module Hackeroo
  class << self
    include Hackeroo::Configurable

    # Delegate to a Hackeroo::Client
    #
    # @return [Hackeroo::Client]
    def client
      @client = Hackeroo::Client.new(options) unless defined?(@client) && @client.hash == options.hash
      @client
    end

    # Has a client been initialized on the Hackeroo module
    #
    # @return [Boolean]
    def client?
      !!@client
    end

    def respond_to_missing?(method_name, include_private=false); client.respond_to?(method_name, include_private); end if RUBY_VERSION >= "1.9"
    def respond_to?(method_name, include_private=false); client.respond_to?(method_name, include_private) || super; end if RUBY_VERSION < "1.9"

  private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end

  end
end

Hackeroo.setup
