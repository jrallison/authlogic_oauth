require File.dirname(__FILE__) + "/authlogic_oauth/version"
require File.dirname(__FILE__) + "/authlogic_oauth/oauth_process"
require File.dirname(__FILE__) + "/authlogic_oauth/acts_as_authentic"
require File.dirname(__FILE__) + "/authlogic_oauth/session"
require File.dirname(__FILE__) + "/authlogic_oauth/helper"

ActiveRecord::Base.send(:include, AuthlogicOauth::ActsAsAuthentic)
Authlogic::Session::Base.send(:include, AuthlogicOauth::Session)
ActionController::Base.helper AuthlogicOauth::Helper