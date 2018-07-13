require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'Valid signup information' do
    get signup_path

    assert_difference 'User.count', 1 do
      post users_path, params: { user: {
        name: 'Julio Doubleblazias',
        email: 'user@valid.com', 
        password: '123456',
        password_confirmation: '123456'          
      }}
    end

    assert is_logged_in?

    follow_redirect!
    assert_template 'users/show'
    assert_select 'div.alert-success'
  end

  test 'INvalid signup information' do
    get signup_path

    assert_no_difference 'User.count' do
      post users_path, params: { user: {
        name: '',
        email: 'user@invalid', 
        password: '12345',
        password_confirmation: '67890'          
      }}
    end

    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
end
