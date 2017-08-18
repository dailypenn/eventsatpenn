class Event < ApplicationRecord
  filterrific(available_filters: %i[search_query with_category])

  belongs_to :org
  validates :title, :location, :category, presence: true
  validate :dates_present?
  validate :valid_dates?

  scope :search_query, (lambda { |query|
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
  })

  scope :with_category, (lambda { |categories|
    where(category: [*categories])
  })

  def dates_present?
    errors.add(title, 'must have dates and times.') if event_date.nil? && start_date.nil? && end_date.nil?
    if event_date.nil?
      errors.add(title, 'must have start time.') if start_date.nil?
      errors.add(title, 'must have end time.') if end_date.nil?
      self.event_date = start_date.to_date unless start_date.nil?
    else
      self.start_date = event_date
      self.end_date = start_date + 86_399
      event_date.to_date
    end
  end

  def valid_dates?
    if end_date.nil?
      errors.add(title, 'must have an end time.') unless all_day
    else
      errors.add(title, 'must end after start time.') unless start_date < end_date
    end
  end

  def fb?
    fbID?
  end

  # TODO: dummy categories
  def self.categories
    %w[Arts Sports Publications]
  end
end
