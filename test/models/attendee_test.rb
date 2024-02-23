require "test_helper"

class AttendeeTest < ActiveSupport::TestCase
  def setup
    @attendee = Attendee.new(
      email: "test@example.com",
      phone_number: "+12345678901",
      credit_card_info: "1234567890123456"
    )
  end

  test "should be valid" do
    assert @attendee.valid?
  end

  test "email should be present" do
    @attendee.email = " "
    assert_not @attendee.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @attendee.email = valid_address
      assert @attendee.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @attendee.email = invalid_address
      assert_not @attendee.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "phone number should be present" do
    @attendee.phone_number = " "
    assert_not @attendee.valid?
  end

  test "phone number should be in the correct format" do
    valid_phone_numbers = %w[+12345678901 +112345678901]
    valid_phone_numbers.each do |valid_phone_number|
      @attendee.phone_number = valid_phone_number
      assert @attendee.valid?, "#{valid_phone_number.inspect} should be valid"
    end
  end

  test "phone number should reject invalid formats" do
    invalid_phone_numbers = %w[12345678901 +12345678 abcdefghij]
    invalid_phone_numbers.each do |invalid_phone_number|
      @attendee.phone_number = invalid_phone_number
      assert_not @attendee.valid?, "#{invalid_phone_number.inspect} should be invalid"
    end
  end

  test "credit card info should be present" do
    @attendee.credit_card_info = " "
    assert_not @attendee.valid?
  end

  test "credit card info should be exactly 16 digits" do
    @attendee.credit_card_info = "123456789012345"
    assert_not @attendee.valid?
  end

  test "credit card info should be numerical" do
    @attendee.credit_card_info = "12345678901234a"
    assert_not @attendee.valid?
  end

  test "associated event tickets should be destroyed" do
    @attendee.save
    @attendee.event_tickets.create!(event_id: events(:one).id)
    assert_difference 'EventTicket.count', -1 do
      @attendee.destroy
    end
  end

  test "associated reviews should be destroyed" do
    @attendee.save
    @attendee.reviews.create!(content: "Lorem ipsum", event_id: events(:one).id)
    assert_difference 'Review.count', -1 do
      @attendee.destroy
    end
  end
end
