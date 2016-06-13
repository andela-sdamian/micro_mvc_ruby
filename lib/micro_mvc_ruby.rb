Gem.find_files('micro_mvc_ruby/**/*.rb').each { |path| require path }
require 'pry'

module MicroMvcRuby
  class Application
    attr_reader :routes

    def initialize
      @routes = Routing::Router.new
    end

    def call(env)
      @request = Rack::Request.new(env)
      route = mapper.map_to_route(@request)
      return route.dispatch if route
      [404, {}, [Notfound.html]]
    end

    def mapper
      @mapper ||= Routing::Mapper.new(routes.endpoints)
    end
  end
end
