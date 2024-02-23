require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attendee = attendees(:one) # Assuming you have fixtures or factories set up
  end

  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should create session when valid credentials are provided" do
    post login_path, params: { email_address: @attendee.email, password: 'password' }
    assert_redirected_to root_url
    assert_equal session[:user_id], @attendee.id
  end

  test "should not create session when invalid credentials are provided" do
    post login_path, params: { email_address: 'invalid@example.com', password: 'invalidpassword' }
    assert_template :new
    assert_nil session[:user_id]
    assert_not_nil flash[:alert]
  end

  test "should destroy session" do
    delete logout_path
    assert_redirected_to root_url
    assert_nil session[:user_id]
    assert_equal flash[:notice], "Logged out successfully!"
  end
end
