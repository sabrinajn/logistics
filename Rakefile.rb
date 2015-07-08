require "./logistcs"

namespace :db do
  desc "Create DBs"
  task :create do
    create(YAML::load(File.open('database.yml'))["development"])
    create(YAML::load(File.open('database.yml'))["test"])
  end

  desc "Do migrations"
  task :migrate_up do
    migrate_up(YAML::load(File.open('database.yml'))["development"])
    migrate_up(YAML::load(File.open('database.yml'))["test"])
  end

  desc "Do migrations"
  task :migrate_down do
    migrate_down(YAML::load(File.open('database.yml'))["development"])
    migrate_down(YAML::load(File.open('database.yml'))["test"])
  end
end

def create(config)
  ActiveRecord::Base.establish_connection(config.merge('database' => nil))
  ActiveRecord::Base.connection.create_database(config['database'], :charset => (config['charset'] || 'utf8'),
                                                :collation => (config['collation'] || 'utf8_general_ci'))
end

def migrate_up(config)
  ActiveRecord::Base.establish_connection(config)
  ActiveRecord::Migrator.up "db/migrate/"
end

def migrate_down(config)
  ActiveRecord::Base.establish_connection(config)
  ActiveRecord::Migrator.down "db/migrate/"
end
