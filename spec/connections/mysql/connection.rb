print "Using MySQL\n"
require 'logger'

ActiveRecord::Base.logger = Logger.new("debug.log")

ActiveRecord::Base.configurations = {
  'mysql' => {
    :adapter => 'mysql',
    :database => 'foreign_key_migrations',
    :username => (ENV["TRAVIS"] ? '' : 'redhillonrails'),
    :encoding => 'utf8',
  }

}

ActiveRecord::Base.establish_connection 'mysql'