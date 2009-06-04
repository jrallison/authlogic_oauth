module AuthlogicOauth
  module Helper
    def oauth_register_button(options = {})
      oauth_button('register_with_oauth', options)
    end
    
    def oauth_login_button(options = {})
      oauth_button('login_with_oauth', options)
    end
  
  private
    def oauth_button(name, options = {})
      "<input type='submit' value='#{options[:value]}' name='#{name}' id='user_submit' class='#{options[:class]}'/>"
    end
  end
end