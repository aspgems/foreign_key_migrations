print "Using PostgreSQL\n"
require 'logger'

ActiveRecord::Base.logger = Logger.new("debug.log")

ActiveRecord::Base.configurations = {
  'postgres' => {
    :adapter => 'postgresql',
    :database => 'foreign_key_migrations',
    :username => 'postgres',
    :min_messages => 'warning'
  }

}

ActiveRecord::Base.establish_connection 'postgres'