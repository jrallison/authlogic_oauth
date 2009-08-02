module AuthlogicOauth
  module ActsAsAuthentic
    def self.included(klass)
      klass.class_eval do
        extend Config
        add_acts_as_authentic_module(Methods, :prepend)
      end
    end

    module Config
      # The name of the oauth token field in the database.
      #
      # * <tt>Default:</tt> :oauth_token
      # * <tt>Accepts:</tt> Symbol
      def oauth_token_field(value = nil)
        rw_config(:oauth_token_field, value, :oauth_token)
      end
      alias_method :oauth_token_field=, :oauth_token_field

      # The name of the oauth token secret field in the database.
      #
      # * <tt>Default:</tt> :oauth_secret
      # * <tt>Accepts:</tt> Symbol
      def oauth_secret_field(value = nil)
        rw_config(:oauth_secret_field, value, :oauth_secret)
      end
      alias_method :oauth_secret_field=, :oauth_secret_field
    end

    module Methods
      include OauthProcess

      # Set up some simple validations
      def self.included(klass)
        klass.class_eval do
          alias_method "#{oauth_token_field.to_s}=".to_sym, :oauth_token=
          alias_method "#{oauth_secret_field.to_s}=".to_sym, :oauth_secret=
        end

        return if !klass.column_names.include?(klass.oauth_token_field.to_s)

        klass.class_eval do
          validate :validate_by_oauth, :if => :authenticating_with_oauth?

          validates_uniqueness_of klass.oauth_token_field, :scope => validations_scope, :if => :using_oauth?
          validates_presence_of klass.oauth_secret_field, :scope => validations_scope, :if => :using_oauth?

          validates_length_of_password_field_options validates_length_of_password_field_options.merge(:if => :validate_password_with_oauth?)
          validates_confirmation_of_password_field_options validates_confirmation_of_password_field_options.merge(:if => :validate_password_with_oauth?)
          validates_length_of_password_confirmation_field_options validates_length_of_password_confirmation_field_options.merge(:if => :validate_password_with_oauth?)
          validates_length_of_login_field_options validates_length_of_login_field_options.merge(:if => :validate_password_with_oauth?)
          validates_format_of_login_field_options validates_format_of_login_field_options.merge(:if => :validate_password_with_oauth?)
        end

        # email needs to be optional for oauth
        klass.validate_email_field = false
      end

      def save(perform_validation = true, &block)
        if perform_validation && block_given? && redirecting_to_oauth_server?
          # Save attributes so they aren't lost during the authentication with the oauth server
          session_class.controller.session[:authlogic_oauth_attributes] = attributes.reject!{|k, v| v.blank?}
          redirect_to_oauth
          return false
        end

        result = super
        yield(result) if block_given?
        result
      end

      # Set the oauth fields
      def oauth_token=(value)
        write_attribute(oauth_token_field, value.blank? ? nil : value)
      end

      def oauth_secret=(value)
        write_attribute(oauth_secret_field, value.blank? ? nil : value)
      end

    private

      def authenticating_with_oauth?
        # Initial request when user presses one of the button helpers
        (session_class.controller.params && !session_class.controller.params[:register_with_oauth].blank?) ||
        # When the oauth provider responds and we made the initial request
        (oauth_response && session_class.controller.session && session_class.controller.session[:oauth_request_class] == self.class.name)
      end

      def authenticate_with_oauth
        # Restore any attributes which were saved before redirecting to the oauth server
        self.attributes = session_class.controller.session.delete(:authlogic_oauth_attributes)
        access_token = generate_access_token

        self.oauth_token = access_token.token
        self.oauth_secret = access_token.secret
      end

      def access_token
        OAuth::AccessToken.new(oauth,
        read_attribute(oauth_token_field),
        read_attribute(oauth_secret_field))
      end

      def using_oauth?
        respond_to?(oauth_token_field) && !oauth_token.blank?
      end

      def validate_password_with_oauth?
        !using_oauth? && require_password?
      end

      def oauth_token_field
        self.class.oauth_token_field
      end

      def oauth_secret_field
        self.class.oauth_secret_field
      end

    end
  end
end