class Event < ApplicationRecord
  filterrific(
    available_filters: [
      :search_query,
      :with_category
    ]
  )

  belongs_to :org
  validates :title, :location, :category, presence: true
  validate :dates_present?
  validate :valid_dates?

  scope :search_query, lambda { |query|
    return nil if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # bracket with '%' to search anywhere in event name/org
    terms = terms.map { |term| '%' + term + '%' }
    # SQL query
    where(
      terms.map { 'LOWER(events.title) LIKE ?' }.join(' AND '),
      *terms.map { |e| [e] }.flatten
    )
  }

  scope :with_category, lambda { |categories|
    where(category: [*categories])
  }

  def dates_present?
    errors.add(title, 'must have valid times.') unless event_date || (start_date && end_date)
    if event_date
      self.start_date = event_date
      self.end_date = start_date + 86_399
      event_date.to_date
    else
      self.event_date = start_date.to_date
    end
  end

  def valid_dates?
    if end_date
      errors.add(start_date.to_s, 'Event must end after start time.') unless start_date < end_date
    else
      errors.add(start_date.to_s, 'Event must have an end time.') unless all_day
    end
  end

  def fb?
    fbID?
  end

  # TODO: dummy categories
  def self.categories
    %w(EVENT_CAUSE)
  end
end
