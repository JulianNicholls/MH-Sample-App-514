require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users :michael
  end

  test 'Login with Valid information' do
    get login_path
    assert_template 'sessions/new'
    
    post login_path, params: { session: {
      email: @user.email,
      password: 'password'
    }}

    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)
  end

  test 'Login with INvalid information' do
    get login_path
    assert_template 'sessions/new'
    
    post login_path, params: { session: {
      email: 'noone@nowhere.com',
      password: '123456'
    }}

    # Ensure the 'invalid' flash appears
    assert_template 'sessions/new'
    assert_not flash.empty?

    # Ensure the flash has gone away
    get root_path
    assert flash.empty?
  end
end
