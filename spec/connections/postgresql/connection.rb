print "Using PostgreSQL\n"
require 'logger'

ActiveRecord::Base.configurations = {
  'fkm' => {
    :adapter => 'postgresql',
    :database => 'fkm_unittest',
    :min_messages => 'warning'
  }

}

ActiveRecord::Base.establish_connection 'fkm'
