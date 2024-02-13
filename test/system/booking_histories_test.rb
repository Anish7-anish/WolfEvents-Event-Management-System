require "application_system_test_case"

class BookingHistoriesTest < ApplicationSystemTestCase
  setup do
    @booking_history = booking_histories(:one)
  end

  test "visiting the index" do
    visit booking_histories_url
    assert_selector "h1", text: "Booking Histories"
  end

  test "creating a Booking history" do
    visit booking_histories_url
    click_on "New Booking History"

    fill_in "Amount", with: @booking_history.amount
    fill_in "Attendee", with: @booking_history.attendee_id
    fill_in "Event", with: @booking_history.event_id
    click_on "Create Booking history"

    assert_text "Booking history was successfully created"
    click_on "Back"
  end

  test "updating a Booking history" do
    visit booking_histories_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @booking_history.amount
    fill_in "Attendee", with: @booking_history.attendee_id
    fill_in "Event", with: @booking_history.event_id
    click_on "Update Booking history"

    assert_text "Booking history was successfully updated"
    click_on "Back"
  end

  test "destroying a Booking history" do
    visit booking_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Booking history was successfully destroyed"
  end
end
