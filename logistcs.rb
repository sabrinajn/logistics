ENV['RACK_ENV'] ||= 'development'

require 'sinatra'
require 'active_record'
require 'active_model'
require 'yaml'

config = YAML::load(File.open('database.yml'))[ENV['RACK_ENV']]
ActiveRecord::Base.establish_connection(config)

module Logistics
  Dir['./lib/*.rb'].each { |lib_file| require lib_file }
  Dir['./lib/models/*.rb'].each { |model| require model }
  Dir['./lib/controllers/*.rb'].each { |controller| require controller }

  class << self
    def route_map
      map = {
        '/maps'   => Logistics::MapController,
        '/search' => Logistics::SearchController
      }

      map
    end
  end
end
