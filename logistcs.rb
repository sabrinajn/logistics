ENV['RACK_ENV'] ||= 'development'

require 'active_record'
require 'active_model'
require 'yaml'

YAML::load(File.open('database.yml'))[ENV['RACK_ENV']].each do |key, value|
  set key, value
end

ActiveRecord::Base.establish_connection(
  adapter: "mysql2",
  host: settings.db_host,
  database: settings.db_name,
  username: settings.db_username,
  password: settings.db_password
)

ActiveRecord::Schema.define(:version => 20150707035328) do
  create_table "maps", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "routes", :force => true do |t|
    t.string   "source"
    t.string   "target"
    t.integer  "distance"
    t.integer  "map_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end

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
