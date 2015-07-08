require 'bundler'
Bundler.require

$: << File.dirname(__FILE__)
require File.dirname(__FILE__) + '/logistcs.rb'

run Rack::URLMap.new Logistics.route_map

