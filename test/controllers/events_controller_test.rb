require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:cat_adoption)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post events_url, params: { event: { category: @event.category, description: @event.description, end_time: @event.end_time, location: @event.location, recurrence_amt: @event.recurrence_amt, recurrence_freq: @event.recurrence_freq, recurring: @event.recurring, start_time: @event.start_time, title: @event.title, twentyone: @event.twentyone } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_url(@event)
    assert_response :success
  end

  test "should update event" do
    patch event_url(@event), params: { event: { category: @event.category, description: @event.description, end_time: @event.end_time, location: @event.location, recurrence_amt: @event.recurrence_amt, recurrence_freq: @event.recurrence_freq, recurring: @event.recurring, start_time: @event.start_time, title: @event.title, twentyone: @event.twentyone } }
    assert_redirected_to event_url(@event)
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
