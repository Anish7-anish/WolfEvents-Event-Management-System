require "test_helper"

class BookingHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @booking_history = booking_histories(:one)
  end

  test "should get index" do
    get booking_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_booking_history_url
    assert_response :success
  end

  test "should create booking_history" do
    assert_difference('BookingHistory.count') do
      post booking_histories_url, params: { booking_history: { amount: @booking_history.amount, attendee_id: @booking_history.attendee_id, event_id: @booking_history.event_id } }
    end

    assert_redirected_to booking_history_url(BookingHistory.last)
  end

  test "should show booking_history" do
    get booking_history_url(@booking_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_booking_history_url(@booking_history)
    assert_response :success
  end

  test "should update booking_history" do
    patch booking_history_url(@booking_history), params: { booking_history: { amount: @booking_history.amount, attendee_id: @booking_history.attendee_id, event_id: @booking_history.event_id } }
    assert_redirected_to booking_history_url(@booking_history)
  end

  test "should destroy booking_history" do
    assert_difference('BookingHistory.count', -1) do
      delete booking_history_url(@booking_history)
    end

    assert_redirected_to booking_histories_url
  end
end
