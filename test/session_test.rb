require File.dirname(__FILE__) + '/test_helper.rb'
 
class SessionTest < ActiveSupport::TestCase
  def test_authenticate_by_record
    session = UserSession.new
    assert session.respond_to?(:record)
    session.record = users(:john)
    assert_equal users(:john), session.record
  end
  
  def test_validate_by_nil_oauth_token
    session = UserSession.new
    assert !session.save
    #assert !redirecting_to_yahoo?
  end
  
  def test_auth_session
    session = UserSession.new
    #assert session.is_auth_session?
  end
  
  def test_validate_by_oauth
    session = UserSession.new
    assert !session.save
    #assert redirecting_to_yahoo?
  end
end