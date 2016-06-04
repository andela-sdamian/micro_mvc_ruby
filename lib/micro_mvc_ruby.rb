require 'micro_mvc_ruby/utilities/object_patching'
require 'micro_mvc_ruby/utilities/string_patching'
require 'micro_mvc_ruby/controllers/base_controller'
require 'micro_mvc_ruby/routing/mapper'
require 'micro_mvc_ruby/routing/router'
require 'micro_mvc_ruby/routing/route'
require 'micro_mvc_ruby/version'

module MicroMvcRuby
  class Application
    attr_reader :routes

    def initialize
      @routes = Routing::Router.new
    end

    def call(env)
      @request = Rack::Request.new(env)
      route = mapper.map_to_route(@request)

      if route
        route.dispatch
      else
        [404, {}, ["Page not found"]]
      end
    end

    def mapper
      @mapper ||= Routing::Mapper.new(routes.endpoints)
    end
  end
end
