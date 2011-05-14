print "Using MySQL\n"
require 'logger'

ActiveRecord::Base.configurations = {
  'fkm' => {
    :adapter => 'mysql',
    :database => 'fkm_unittest',
    :username => 'fkm',
    :encoding => 'utf8',
    :socket => '/var/run/mysqld/mysqld.sock',
    :min_messages => 'warning'
  }

}

ActiveRecord::Base.establish_connection 'fkm'
