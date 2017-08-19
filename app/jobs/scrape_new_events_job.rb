class ScrapeNewEventsJob < ApplicationJob
  queue_as :default

  def perform(org, access_token)
    group = FbGraph2::Page.new(org.fbID).authenticate(access_token)
    added_events = 0
    group.events.each do |event|
      evt = event.fetch(fields: 'name, category, description, place, start_time, end_time, id')
      if Event.find_by(fbID: evt.id).nil?
        create_event_for_org(org, evt)
        added_events += 1
      end
    end
  end

  def create_event_for_org(org, event)
    place = event.raw_attributes['place']
    new_event = Event.new(
      title: event.name, start_date: event.start_time,
      category: event.raw_attributes['category'],
      end_date: event.end_time, description: event.description,
      all_day: false, recurring: false,
      location: "#{place['name']}, #{place['location']['street']}",
      location_lat: place['location']['latitude'],
      location_lon: place['location']['longitude'], fbID: event.id
    )
    org.events << new_event
  end
end
