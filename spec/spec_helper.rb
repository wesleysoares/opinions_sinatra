ENV['RACK_ENV'] = 'test'
require 'rspec'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Capybara::DSL
end
