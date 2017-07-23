class Event < ApplicationRecord
  filterrific(
    available_filters: [
      :search_query,
      :with_category
    ]
  )

  belongs_to :org

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

  def fb?
    fbID?
  end

  # TODO: dummy categories
  def self.categories
    %w(Arts Sports)
  end
end
