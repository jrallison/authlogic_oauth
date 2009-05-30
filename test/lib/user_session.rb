class UserSession < Authlogic::Session::Base
  
  def self.oauth_consumer
    OAuth::Consumer.new("CONSUMER_TOKEN", "CONSUMER_SECRET", { :site=>"http://example.com" })
  end
  
end