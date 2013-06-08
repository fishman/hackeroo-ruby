require 'faraday'
require 'faraday/request/multipart'
require 'hackeroo/configurable'
require 'hackeroo/error/client_error'
require 'hackeroo/error/server_error'
require 'hackeroo/response/parse_json'
require 'hackeroo/response/raise_error'
require 'hackeroo/version'

module Hackeroo
  module Default
    ENDPOINT = 'http://api.hackeroo.io' unless defined? Hackeroo::Default::ENDPOINT
    CONNECTION_OPTIONS = {
      :headers => {
        :accept => 'application/json',
        :user_agent => "Hackeroo Ruby Gem #{Hackeroo::Version}",
      },
      :request => {
        :open_timeout => 5,
        :timeout => 10,
      },
    } unless defined? Hackeroo::Default::CONNECTION_OPTIONS
    IDENTITY_MAP = false unless defined? Hackeroo::Default::IDENTITY_MAP
    MIDDLEWARE = Faraday::Builder.new do |builder|
      # Convert request params to "www-form-urlencoded"
      builder.use Faraday::Request::UrlEncoded
      # Handle 4xx server responses
      builder.use Hackeroo::Response::RaiseError, Hackeroo::Error::ClientError
      # Parse JSON response bodies using MultiJson
      builder.use Hackeroo::Response::ParseJson
      # Handle 5xx server responses
      builder.use Hackeroo::Response::RaiseError, Hackeroo::Error::ServerError
      # Set Faraday's HTTP adapter
      builder.adapter Faraday.default_adapter
    end unless defined? Hackeroo::Default::MIDDLEWARE

    class << self

      # @return [Hash]
      def options
        Hash[Hackeroo::Configurable.keys.map{|key| [key, send(key)]}]
      end

      # @return [String]
      def clientkey
        ENV['HACKEROO_CLIENTKEY']
      end

      # @note This is configurable in case you want to use a Hackeroo-compatible endpoint.
      # @see http://status.net/wiki/Hackeroo-compatible_API
      # @see http://en.blog.wordpress.com/2009/12/12/hackeroo-api/
      # @see http://staff.tumblr.com/post/287703110/api
      # @see http://developer.typepad.com/typepad-hackeroo-api/hackeroo-api.html
      # @return [String]
      def endpoint
        ENDPOINT
      end

      def connection_options
        CONNECTION_OPTIONS
      end

      def identity_map
        IDENTITY_MAP
      end

      # @note Faraday's middleware stack implementation is comparable to that of Rack middleware.  The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
      # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
      # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
      # @return [Faraday::Builder]
      def middleware
        MIDDLEWARE
      end

    end
  end
end
