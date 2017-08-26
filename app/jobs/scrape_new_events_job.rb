class ScrapeNewEventsJob < ApplicationJob
  queue_as :default

  # This is a special use token that should only be used for serverside calls.
  # This string value works in place of an "App Token," which is generated by
  # facebook server-side when this is substituted for an access token. See
  # https://developers.facebook.com/docs/facebook-login/access-tokens#apptokens
  def application_token
    app_id  = Rails.application.secrets.fb_app_id
    app_sec = Rails.application.secrets.fb_app_secret
    "#{app_id}|#{app_sec}"
  end

  def perform(org, access_token = application_token)
    logger.debug "Scraping events for #{org.name}"
    group = FbGraph2::Page.new(org.fbID).authenticate(access_token)
    added_events = 0
    group.events.each do |event|
      evt = event.fetch(fields: 'name,category,description,place,start_time,end_time,id')
      if Event.find_by(fbID: evt.id).nil?
        create_event_for_org(org, evt)
        added_events += 1
      end
    end
    logger.debug "Added #{added_events} events for #{org.name}"
  end

  def create_event_for_org(org, event)
    return if event.nil?
    place = event.raw_attributes['place']
    if place.nil?
      lat = 0
      lon = 0
    elsif place['location'].nil? && !place['name'].nil?
      # TODO: this means that the place is an address, not like a landmark
      # place['name'].getLatLng() # or whatever,
      # we can do this with mapbox or google probs
      lat = 0
      lon = 0
    else
      lat = place['location']['latitude']
      lon = place['location']['longitude']
    end
    logger.debug "Creating event #{event.name} for #{org.name}"
    new_event = Event.new(
      title: event.name, start_date: event.start_time,
      category: event.raw_attributes['category'],
      end_date: event.end_time, description: event.description,
      all_day: false, recurring: false,
      location: location_str(place),
      location_lat: lat,
      location_lon: lon, fbID: event.id
    )
    new_event.save
    Rails.logger.error(new_event.errors.inspect) if new_event.errors.any?
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
