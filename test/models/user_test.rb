require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new name: 'Example User', email: 'user@example.com'
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '   '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '   '
    assert_not @user.valid?
  end

  test 'name should be a certain length' do
    @user.name = 'aa'
    assert_not @user.valid?
    
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should be a certain length' do
    @user.email = 'aaaaaa'
    assert_not @user.valid?

    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'email should accept valid addresses' do 
    valid_addresses = %w[
      user@example.com USER@foo.com A_US-ER@foo.bar.org A_UK+US-ER@foo.bar.org.uk
      first.last@com.net alice+baz@a.cn a@b.tv user@hyphenated-dot.com
    ]

    valid_addresses.each do |addr|
      @user.email = addr
      assert @user.valid?, "#{addr.inspect} should be valid"
    end 
  end

  test 'email should reject INvalid addresses' do 
    invalid_addresses = %w[
      user@example,com user_at_foo.org user.name@example. foo@bar_baz.com
      foo@bar+baz.com foo@bar..com
    ]

    invalid_addresses.each do |addr|
      @user.email = addr
      assert_not @user.valid?, "#{addr.inspect} should be INvalid"
    end 
  end

  test 'Email addresses must be unique, case-sensitively' do
    duplicate = @user.dup
    duplicate.email.upcase!
    @user.save
    assert_not duplicate.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
end
