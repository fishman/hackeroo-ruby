require 'faraday'
require 'multi_json'
require 'hackeroo/api/users'
require 'hackeroo/api/performances'
require 'hackeroo/api/stages'
require 'hackeroo/api/artists'
require 'hackeroo/configurable'
require 'hackeroo/error/client_error'
require 'hackeroo/error/decode_error'
require 'base64'
require 'uri'

module Hackeroo
  # Wrapper for the Hackeroo REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in {http://dev.hackeroo.com/doc the Hackeroo API Documentation}.
  # @see http://dev.hackeroo.com/pages/every_developer
  class Client
    include Hackeroo::API::Users
    include Hackeroo::API::Performances
    include Hackeroo::API::Stages
    include Hackeroo::API::Artists
    include Hackeroo::Configurable

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Hackeroo::Client]
    def initialize(options={})
      Hackeroo::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || Hackeroo.instance_variable_get(:"@#{key}"))
      end
    end

    # Perform an HTTP GET request
    def get(path, params={})
      request(:get, path, params)
    end

  private

    # Returns a proc that can be used to setup the Faraday::Request headers
    #
    # @param method [Symbol]
    # @param path [String]
    # @param params [Hash]
    # @return [Proc]
    def request_setup(method, path, params)
      Proc.new do |request|
        request.headers['x-app-id'] = @clientkey
        request.headers[:content_type] = 'application/json'
        request.headers[:accept] = 'application/json'
      end
    end

    def request(method, path, params={}, signature_params=params)
      request_setup = request_setup(method, path, params)
      connection.send(method.to_sym, path, params, &request_setup).env
    rescue Faraday::Error::ClientError
      raise Hackeroo::Error::ClientError
    rescue MultiJson::DecodeError
      raise Hackeroo::Error::DecodeError
    end

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new(@endpoint, @connection_options.merge(:builder => @middleware))
    end

  end
end
