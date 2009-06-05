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
    assert !redirecting_to_oauth?
  end
  
  def test_validate_by_oauth
    controller.stubs(:params).returns({ :login_with_oauth => true })
    session = UserSession.new
    assert !session.save
    assert redirecting_to_oauth?
  end
end