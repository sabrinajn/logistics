require 'bundler/setup'
Bundler.require :default, :test

ENV['RACK_ENV'] = 'test'
spec_root = File.expand_path(File.dirname(__FILE__))
$: << spec_root
$: << File.expand_path(File.join(File.dirname(__FILE__), '..'))

require File.dirname(__FILE__) + '/../logistcs'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
