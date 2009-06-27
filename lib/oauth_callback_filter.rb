class OauthCallbackFilter
  def initialize(app)
    @app = app
  end
  
  def call(env)
    unless env["rack.session"][:oauth_callback_method].blank?
      env["REQUEST_METHOD"] = env["rack.session"].delete(:oauth_callback_method).to_s.upcase
    end
    @app.call(env)
  end
end