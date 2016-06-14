require "micro_mvc_ruby"

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "app", "controllers")
$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "app", "models")

module Todo
  class Application < MicroMvcRuby::Application; end
end

