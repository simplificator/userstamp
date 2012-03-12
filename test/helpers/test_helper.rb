$:.unshift(File.dirname(__FILE__) + '/../..')
$:.unshift(File.dirname(__FILE__) + '/../../lib')
schema_file = File.join(File.dirname(__FILE__), '..', 'schema.rb')

require 'test/unit'
require 'rubygems'

gem 'activesupport', '>= 3.0'
require 'active_support'

gem 'activerecord', '>= 3.0'
require 'active_record'

gem 'actionpack', '>= 3.0'
require 'action_controller'

require 'init'

config = YAML::load(IO.read(File.join(File.dirname(__FILE__), '..', 'database.yml')))[ENV['DB'] || 'test']
ActiveRecord::Base.configurations = config
ActiveRecord::Base.establish_connection(config)

load(schema_file) if File.exist?(schema_file)

class ActiveSupport::TestCase
  include ActiveRecord::TestFixtures
  
  self.fixture_path = File.join(File.dirname(__FILE__), '..', 'fixtures')
  
  # Turn off transactional fixtures if you're working with MyISAM tables in MySQL
  self.use_transactional_fixtures = true
  
  # Instantiated fixtures are slow, but give you @david where you otherwise would need people(:david)
  self.use_instantiated_fixtures  = true

  # Add more helper methods to be used by all tests here...
end
