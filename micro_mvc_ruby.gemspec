# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'micro_mvc_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'micro_mvc_ruby'
  spec.version       = MicroMvcRuby::VERSION
  spec.authors       = ['Damian Simon Peter']
  spec.email         = ['simon.peter@andela.com']

  spec.summary       = 'An MVC framework implemented in Ruby with Rack'
  spec.description   = 'MicroMvcRuby is an MVC framework that allows you
                          to build modern MVC applications using Rack and Ruby.
                          Find out more on our GitHub repo.
                         '
  spec.homepage      = 'https://github.com/andela-sdamian/micro_mvc_ruby'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect
    against public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency "rspec", "~> 3.4.0"
  spec.add_development_dependency "capybara",  "~> 2.7.1"
  spec.add_development_dependency "database_cleaner", "~> 1.5.3"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "factory_girl", "~> 4.0.0"
  
  spec.add_runtime_dependency "rack", "~> 1.6.4"
  spec.add_runtime_dependency "tilt", "~> 2.0.4"
  spec.add_runtime_dependency "sqlite3", "~> 1.3.11"
  spec.add_runtime_dependency "pry"
end
