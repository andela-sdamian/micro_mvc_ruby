module MicroMvcRuby
  module Routing
    class Router
      attr_reader :route_data

      def draw(&block)
        instance_eval(&block)
        self
      end
    end
  end
end
