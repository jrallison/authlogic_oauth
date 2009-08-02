module AuthlogicOauth
  module OauthProcess

  private

    def validate_by_oauth
      validate_email_field = false

      if oauth_response.blank?
        redirect_to_oauth
      else
        authenticate_with_oauth
      end
    end

    def redirecting_to_oauth_server?
      authenticating_with_oauth? && oauth_response.blank?
    end

    def redirect_to_oauth
      request = oauth.get_request_token :oauth_callback => build_callback_url
      oauth_controller.session[:oauth_request_token]        = request.token
      oauth_controller.session[:oauth_request_token_secret] = request.secret

      # Store the class which is redirecting, so we can ensure other classes
      # don't get confused and attempt to use the response
      oauth_controller.session[:oauth_request_class] = self.class.name

      # Tell our rack callback filter what method the current request is using
      oauth_controller.session[:oauth_callback_method]      = oauth_controller.request.method

      oauth_controller.redirect_to request.authorize_url
    end

    def build_callback_url
      oauth_controller.url_for :controller => oauth_controller.controller_name, :action => oauth_controller.action_name
    end

    def request_token
      OAuth::RequestToken.new(oauth,
      oauth_controller.session[:oauth_request_token],
      oauth_controller.session[:oauth_request_token_secret])
    end

    def generate_access_token
      request_token.get_access_token(:oauth_verifier => oauth_controller.params[:oauth_verifier])
    end

    def oauth_response
      oauth_controller.params && oauth_controller.params[:oauth_token]
    end

    def oauth_controller
      is_auth_session? ? controller : session_class.controller
    end

    def oauth
      is_auth_session? ? self.class.oauth_consumer : session_class.oauth_consumer
    end

    def is_auth_session?
      self.is_a?(Authlogic::Session::Base)
    end

  end
end