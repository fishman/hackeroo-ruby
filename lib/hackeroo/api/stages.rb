require 'hackeroo/api/arguments'
require 'hackeroo/api/utils'
require 'hackeroo/core_ext/enumerable'
require 'hackeroo/error/not_found'
require 'hackeroo/stage'

module Hackeroo
  module API
    module Stages
      include Hackeroo::API::Utils
      MAX_USERS_PER_REQUEST = 100

      def stages(*args)
        arguments = Twitter::API::Arguments.new(args)
        # merge_user!(arguments.options, user)
        object_from_response(Hackeroo::Performance, :get, "/api/v1/stages.json", arguments.options)
      end


    end
  end
end
