module MicroMvcRuby
  module Routing
    class Route
      attr_reader :controller, :request, :action

      def initialize(request, controller_and_action)
        @request = request
        @controller, @action = controller_and_action
      end

      def controller_class
        controller.constantize
      end

      def dispatch
        controller = controller_class.new(request)
        controller.send(action)
        controller.render(action) unless controller.server_response
        controller.server_response
      end
    end
  end
end
