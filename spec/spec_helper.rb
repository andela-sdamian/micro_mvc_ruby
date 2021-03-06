require 'simplecov'
SimpleCov.start

require 'coveralls'
require 'micro_mvc_ruby'
require 'rack'
require 'rspec'
require 'todo_application/app/models/task'
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

RSpec.shared_context type: :feature do
  require 'capybara/rspec'
  before(:all) do
    app = Rack::Builder.parse_file(
      "#{__dir__}/todo_application/config.ru"
    ).first
    Capybara.app = app
  end
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end

ENV['RACK_ENV'] = 'test'
