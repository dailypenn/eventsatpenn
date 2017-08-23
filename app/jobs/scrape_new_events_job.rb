class ScrapeNewEventsJob < ApplicationJob
  queue_as :default

  def perform(org, access_token)
    group = FbGraph2::Page.new(org.fbID).authenticate(access_token)
    added_events = 0
    group.events.each do |event|
      evt = event.fetch(fields: 'name,category,description,place,start_time,end_time,id')
      if Event.find_by(fbID: evt.id).nil?
        create_event_for_org(org, evt)
        added_events += 1
      end
    end
  end

  def create_event_for_org(org, event)
    return if event.nil?
    place = event.raw_attributes['place']
    if place.nil? || place['location'].nil?
      lat = 0
      lon = 0
    else
      lat = place['location']['latitude']
      lon = place['location']['longitude']
    end
    new_event = Event.new(
      title: event.name, start_date: event.start_time,
      category: event.raw_attributes['category'],
      end_date: event.end_time, description: event.description,
      all_day: false, recurring: false,
      location: location_str(place),
      location_lat: lat,
      location_lon: lon, fbID: event.id
    )
    org.events << new_event
  end

  def location_str(place)
    return '' if place.nil?
    if place['location'].nil?
      place['name'] unless place['name'].nil?
    else
      "#{place['name']}, #{place['location']['street']}"
    end
  end
end
