ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'backbone.rb')
require 'rspec'
require 'rack/test'

set :run, false
set :raise_errors, true

def app
	Backbone.new
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end