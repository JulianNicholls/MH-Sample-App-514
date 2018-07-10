require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full_title helper' do
    assert_equal full_title, 'Ruby on Rails Tutorial App'
    assert_equal full_title('Contact'), 'Contact | Ruby on Rails Tutorial App'
  end
end