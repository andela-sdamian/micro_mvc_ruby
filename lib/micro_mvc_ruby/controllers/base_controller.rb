require 'tilt'

module MicroMvcRuby
  class BaseController
    attr_reader :request, :params

    def initialize(request)
      @request = request 
      @params = request.params
    end

    def response(body, status = 200, headers = {})
      @response = Rack::Response.new(body, status, headers)
    end

    def server_response
      @response
    end

    def redirect_to(url)
      @response = response({}, 302, 'location' => url)
    end

    def render(*args)
      response(view_template(*args))
    end

    def view_path(view_name)
      File.join(
        [APP_ROOT, 'app', 'views', controller_name, "#{view_name}.html.erb"]
      )
    end

    def view_template(view_name, locals = {})
      Tilt::ERBTemplate.new(view_path(view_name))
                       .render(self)
    end

    # def view_variables
    #   hash = {}
    #   variables  = instance_variables
    #   variables.each { |var| hash[var[1..-1]] = instance_variable_get(var) }
    #   require 'ostruct'
    #   require 'pry'
    #   binding.pry 
    #   OpenStruct.new(hash)
    # end

    def controller_name
      self.class.to_s.gsub(/Controller$/, '').snake_case
    end
  end
end
