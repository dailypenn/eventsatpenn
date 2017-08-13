class ScrapeNewEventsJob < ApplicationJob
  queue_as :default

  def perform(org, access_token)
    group = FbGraph2::Group.new(org.fbID).authenticate(access_token)
    added_events = 0
    group.events.each do |event|
      if Event.find_by(fbID: event.id).nil?
        create_event_for_org(org, event)
        added_events += 1
      end
    end
    p "Created #{added_events} events for #{org.name}"
  end

  def create_event_for_org(org, event)
    place = event.raw_attributes['place']
    new_event = Event.new(
      title: event.name, start_date: event.start_time,
      category: 'Unknown',
      end_date: event.end_time, description: event.description,
      location: "#{place['name']}, #{place['location']['street']}",
      location_lat: place['location']['latitude'],
      location_lon: place['location']['longitude'], fbID: event.id
    )
    org.events << new_event
  end
end
