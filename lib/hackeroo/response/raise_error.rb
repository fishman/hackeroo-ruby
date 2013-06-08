require 'faraday'
require 'hackeroo/error/bad_gateway'
require 'hackeroo/error/bad_request'
require 'hackeroo/error/forbidden'
require 'hackeroo/error/gateway_timeout'
require 'hackeroo/error/internal_server_error'
require 'hackeroo/error/not_acceptable'
require 'hackeroo/error/not_found'
require 'hackeroo/error/service_unavailable'
require 'hackeroo/error/too_many_requests'
require 'hackeroo/error/unauthorized'
require 'hackeroo/error/unprocessable_entity'

module Hackeroo
  module Response
    class RaiseError < Faraday::Response::Middleware

      def on_complete(env)
        status_code = env[:status].to_i
        error_class = @klass.errors[status_code]
        raise error_class.from_response(env) if error_class
      end

      def initialize(app, klass)
        @klass = klass
        super(app)
      end

    end
  end
end
