require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get newregistration" do
    get :newregistration
    assert_response :success
  end

  test "should get forgotpassword" do
    get :forgotpassword
    assert_response :success
  end

end
