module AuthlogicOauth
  # This module is responsible for adding oauth
  # to the Authlogic::Session::Base class.
  module Session
    def self.included(klass)
      klass.class_eval do
        extend Config
        include Methods
      end
    end

    module Config
      # * <tt>Default:</tt> :find_by_oauth_token
      # * <tt>Accepts:</tt> Symbol
      def find_by_oauth_method(value = nil)
        rw_config(:find_by_oauth_method, value, :find_by_oauth_token)
      end
      alias_method :find_by_oauth_method=, :find_by_oauth_method
    end

    module Methods
      include OauthProcess

      def self.included(klass)
        klass.class_eval do
          validate :validate_by_oauth, :if => :authenticating_with_oauth?
        end
      end

      # Hooks into credentials so that you can pass a user who has already has an oauth access token.
      def credentials=(value)
        super
        values = value.is_a?(Array) ? value : [value]
        hash = values.first.is_a?(Hash) ? values.first.with_indifferent_access : nil
        self.record = hash[:priority_record] if !hash.nil? && hash.key?(:priority_record)
      end

      def record=(record)
        @record = record
      end

      # Clears out the block if we are authenticating with oauth,
      # so that we can redirect without a DoubleRender error.
      def save(&block)
        block = nil if redirecting_to_oauth_server?
        super(&block)
      end

    private

      def authenticating_with_oauth?
        # Initial request when user presses one of the button helpers
        (controller.params && !controller.params[:login_with_oauth].blank?) ||
        # When the oauth provider responds and we made the initial request
        (oauth_response && controller.session && controller.session[:oauth_request_class] == self.class.name)
      end

      def authenticate_with_oauth
        if @record
          self.attempted_record = record
        else
          self.attempted_record = search_for_record(find_by_oauth_method, generate_access_token.token)
          #errors.add_to_base("Unable to authenticate with Twitter.")
        end

        if !attempted_record
          errors.add_to_base("Could not find user in our database, have you registered with your oauth account?")
        end
      end

      def find_by_oauth_method
        self.class.find_by_oauth_method
      end
    end
  end
end