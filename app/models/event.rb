class Event < ApplicationRecord
  filterrific(available_filters: %i[search_query with_category])

  belongs_to :org
  validates :title, :location, :category, presence: true
  validate :dates_present?
  validate :valid_dates?
  validate :category?

  before_validation :set_category

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

  def category?
    self.category = 'Other' unless Event.categories.include?(category)
  end

  def set_category
    return if Event.categories.include?(category)
    case category
    when 'CLASS_EVENT'
      self.category = 'Academic'
    when 'ART_EVENT', 'ART_FILM', 'BOOK_EVENT', 'EVENT_ART', 'EVENT_LITERATURE', 'MOVIE_EVENT'
      self.category = 'Arts'
    when 'SPORTS_EVENT', 'FITNESS'
      self.category = 'Athletic'
    when 'NETWORKING'
      self.category = 'Career and Professional'
    when 'EVENT_CAUSE', 'FUNDRAISER', 'VOLUNTEERING'
      self.category = 'Charity and Community Service'
    when 'FESTIVAL_EVENT', 'MUSIC', 'MUSIC_EVENT'
      self.category = 'Concerts and Festivals'
    when 'CONFERENCE_EVENT'
      self.category = 'Conferences'
    when 'COMMUNITY'
      self.category = 'Ethnic and Cultural'
    when 'EVENT_FOOD', 'FOOD_DRINK', 'FOOD_TASTING', 'DINING_EVENT'
      self.category = 'Food'
    when 'HEALTH_WELLNESS'
      self.category = 'Health and Wellness'
    when 'LECTURE'
      self.category = 'Lectures and Speakers'
    when 'MEETUP'
      self.category = 'Meetings'
    when 'RELIGIOUS_EVENT'
      self.category = 'Religious and Spiritual'
    when 'NIGHTLIFE', 'PARTIES_NIGHTLIFE'
      self.category = 'Social'
    when 'COMEDY_EVENT', 'DANCE_EVENT', 'THEATER_EVENT', 'THEATER_DANCE'
      self.category = 'Theater and Performances'
    when 'WORKSHOP'
      self.category = 'Workshops'
    else
      self.category = 'Other'
    end
  end

  def fb?
    !fbID.empty?
  end

  def self.categories
    ['Academic', 'Arts', 'Athletic', 'Career and Professional',
     'Charity and Community Service', 'Concerts and Festivals', 'Conferences',
     'Ethnic and Cultural', 'Food', 'Greek', 'Health and Wellness',
     'Lectures and Speakers', 'Meetings', 'Political',
     'Religious and Spiritual', 'Social', 'Student Government',
     'Theater and Performances', 'Workshops', 'Other']
  end
end
