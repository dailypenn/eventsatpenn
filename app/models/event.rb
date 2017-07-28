class Event < ApplicationRecord
  filterrific(
    available_filters: [
      :search_query,
      :with_category
    ]
  )

  belongs_to :org
  validates :title, :start_date, :end_date, :location, :category, presence: true
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

  def valid_dates?
    errors.add(start_date.to_s, 'Event must end after start time.') unless start_date < end_date
  end

  def fb?
    fbID?
  end

  # TODO: dummy categories
  def self.categories
    %w(Arts Sports Publications)
  end
end
