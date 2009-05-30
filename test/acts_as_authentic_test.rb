require File.dirname(__FILE__) + '/test_helper.rb'
 
class ActsAsAuthenticTest < ActiveSupport::TestCase
  def test_included
    assert User.send(:acts_as_authentic_modules).include?(AuthlogicOauth::ActsAsAuthentic::Methods)
    assert_equal :validate_password_with_oauth?, User.validates_length_of_password_field_options[:if]
    assert_equal :validate_password_with_oauth?, User.validates_confirmation_of_password_field_options[:if]
    assert_equal :validate_password_with_oauth?, User.validates_length_of_password_confirmation_field_options[:if]
    assert_equal :validate_password_with_oauth?, User.validates_length_of_login_field_options[:if]
    assert_equal :validate_password_with_oauth?, User.validates_format_of_login_field_options[:if]
  end
  
  def test_required_fields_on_create
    user = User.new
    assert !user.save
    assert user.errors.on(:login)
    assert user.errors.on(:password)
    assert user.errors.on(:password_confirmation)
  end
  
  def test_fields_not_required_on_create_if_using_oauth
    user = User.new
    user.oauth_token = "SLDKJSD"
    assert !user.save {} # because we are redirecting, the user was NOT saved
    #assert redirecting_to_oauth?
  end
  
  def test_login_not_required_on_update_if_using_oauth
    john = users(:john)
    assert_nil john.login
    assert john.save
  end
  
  def test_password_not_required_on_update_if_using_oauth
    john = users(:john)
    assert_nil john.crypted_password
    assert john.save
  end
  
  def test_email_not_required_on_update_if_using_oauth
    john = users(:john)
    assert_nil john.email
    assert john.save
  end
  
  def test_fields_required_on_update_if_not_using_oauth
    john = users(:john)
    john.oauth_token = nil
    assert_nil john.login
    assert_nil john.crypted_password
    assert_nil john.email
    assert !john.save
    
    assert john.errors.on(:login)
    assert john.errors.on(:password)
    assert john.errors.on(:password_confirmation)
  end
  
  def test_validates_uniqueness_of_oauth_token
    u = User.new(:oauth_token => "johns_token")
    assert !u.valid?
    assert u.errors.on(:oauth_token)
  end
  
  def test_blank_oauth_token_gets_set_to_nil
    u = User.new(:oauth_token => "")
    assert_nil u.oauth_token
  end
  
  def test_blank_oauth_secret_gets_set_to_nil
    u = User.new(:oauth_secret => "")
    assert_nil u.oauth_secret
  end
  
  def test_updating_without_oauth
    john = users(:john)
    john.oauth_token = nil
    john.login = "john"
    john.email = "john@example.com"
    john.password = "test"
    john.password_confirmation = "test"
    assert john.save
    #assert !redirecting_to_yahoo?
  end
    
  def test_updating_without_validation
    john = users(:john)
    john.oauth_token = "SDSDGSDGSD"
    assert john.save(false)
    #assert !redirecting_to_yahoo?
  end
  
  def test_updating_without_a_block
    john = users(:john)
    john.oauth_token = "SDSDGSDGSD"
    assert john.save
    john.reload
    assert_equal "SDSDGSDGSD", john.oauth_token
  end
end