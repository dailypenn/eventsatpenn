json.extract! event, :id, :title, :start_time, :end_time, :description, :location, :category, :twentyone, :recurring, :recurrence_freq, :recurrence_amt, :created_at, :updated_at
json.url event_url(event, format: :json)
