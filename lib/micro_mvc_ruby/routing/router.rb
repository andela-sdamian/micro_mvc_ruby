module MicroMvcRuby 
  module Routing
    class Router
      attr_accessor :endpoints

      def draw(&block)
        instance_eval &block
      end

      def root(to)
        get "/", to: to
      end

      def endpoints
        @endpoints ||= Hash.new { |hash, key| hash[key] = [] }
      end

      def self.verbs
         [:get, :post, :put, :patch, :delete]
      end

      private

      def pattern(path)
        placeholders = []
        reg_exp_part = path.gsub(/(:\w+)/) do |match|
          placeholders << match[1..-1].freeze
          "(?<#{placeholders.last}>[^/?#]+)"
        end

        [/^#{reg_exp_part}$/, placeholders]
      end

      def controller_and_action_for(target)
        if target =~ /^([^#]+)#([^#]+)$/
          return [
            "#{Regexp.last_match(1).camel_case}Controller",
            Regexp.last_match(2).to_sym]
        end
      end

      verbs.each do |method_name|
        define_method(method_name) do |path, to:|
          path = "/#{path}" unless path[0] == "/"
          controller_and_action = controller_and_action_for(to)
          @route_data = { path: path,
                          pattern: pattern(path),
                          controller_and_action: controller_and_action
                        }
          endpoints[method_name] << @route_data
        end
      end
    end
  end
end
