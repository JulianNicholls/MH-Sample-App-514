require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
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
