require 'bundler'
Bundler.require :default, :test

ENV['RACK_ENV'] = 'test'
require File.expand_path(File.dirname(__FILE__) + '/../../logistcs.rb')

require 'rspec'
require 'rack/test'

Before do
  Logistics::Map.delete_all
end

class LogisticsWorld
  include RSpec::Expectations
  include RSpec::Matchers
  include Rack::Test::Methods

  def app
    Rack::URLMap.new Logistics.route_map
  end
end

World do
  LogisticsWorld.new
end
