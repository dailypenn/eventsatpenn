json.extract! event, :title, :start_date, :end_date, :all_day, :description, :location, :location_lat, :location_lon, :category, :fbID, :twentyone, :recurring, :recurrence_freq, :recurrence_amt, :org
json.url event_url(event, format: :json)
