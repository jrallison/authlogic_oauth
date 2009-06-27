require "authlogic_oauth"

# Throw callback rack app into the middleware stack
ActionController::Dispatcher.middleware = ActionController::MiddlewareStack.new do |m|
  ActionController::Dispatcher.middleware.each do |klass|
    m.use klass
  end
  m.use OauthCallbackFilter
end