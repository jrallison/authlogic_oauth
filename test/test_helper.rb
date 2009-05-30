require "test/unit"
require "rubygems"
require "oauth"
require "ruby-debug"
require "active_record"
require "active_record/fixtures"

ActiveRecord::Schema.verbose = false
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")
ActiveRecord::Base.configurations = true
ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.datetime  :created_at      
    t.datetime  :updated_at
    t.integer   :lock_version, :default => 0
    t.string    :login
    t.string    :crypted_password
    t.string    :password_salt
    t.string    :persistence_token
    t.string    :single_access_token
    t.string    :perishable_token
    t.string    :oauth_token
    t.string    :oauth_secret
    t.string    :email
    t.integer   :login_count, :default => 0, :null => false
    t.integer   :failed_login_count, :default => 0, :null => false
    t.datetime  :last_request_at
    t.datetime  :current_login_at
    t.datetime  :last_login_at
    t.string    :current_login_ip
    t.string    :last_login_ip
  end
end

require File.dirname(__FILE__) + '/../../authlogic/lib/authlogic' unless defined?(Authlogic)
require File.dirname(__FILE__) + '/../../authlogic/lib/authlogic/test_case'
require File.dirname(__FILE__) + '/../lib/authlogic_oauth' unless defined?(AuthlogicOauth)
require File.dirname(__FILE__) + '/lib/user'
require File.dirname(__FILE__) + '/lib/user_session'

class ActiveSupport::TestCase
  include ActiveRecord::TestFixtures
  self.fixture_path = File.dirname(__FILE__) + "/fixtures"
  self.use_transactional_fixtures = false
  self.use_instantiated_fixtures  = false
  self.pre_loaded_fixtures = false
  fixtures :all
  setup :activate_authlogic
end