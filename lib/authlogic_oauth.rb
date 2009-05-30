require File.dirname(__FILE__) + "/authlogic_oauth/version"
require File.dirname(__FILE__) + "/authlogic_oauth/oauth_process"
require File.dirname(__FILE__) + "/authlogic_oauth/acts_as_authentic"
require File.dirname(__FILE__) + "/authlogic_oauth/session"

ActiveRecord::Base.send(:include, AuthlogicOauth::ActsAsAuthentic)
Authlogic::Session::Base.send(:include, AuthlogicOauth::Session)