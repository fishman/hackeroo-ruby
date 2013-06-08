require 'hackeroo/api/arguments'
require 'hackeroo/api/utils'
require 'hackeroo/core_ext/enumerable'
require 'hackeroo/error/not_found'
require 'hackeroo/user'

module Hackeroo
  module API
    module Users
      include Hackeroo::API::Utils
      MAX_USERS_PER_REQUEST = 100

      def update_delivery_device(device, options={})
        object_from_response(Hackeroo::User, :post, "/1.1/account/update_delivery_device.json", options.merge(:device => device))
      end


      def user(*args)
        arguments = Twitter::API::Arguments.new(args)
        # merge_user!(arguments.options, user)
        object_from_response(Hackeroo::User, :get, "/api/v1/performances.json", arguments.options)
      end


    end
  end
end
