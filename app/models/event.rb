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
    where(display_category: [*categories])
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
    self.display_category = 'Other' unless Event.categories.include?(display_category)
  end

  def set_category
    self.display_category = category if Event.categories.include?(category)
    return if display_category
    case category
    when 'CLASS_EVENT'
      self.display_category = 'Academic'
    when 'ART_EVENT', 'ART_FILM', 'BOOK_EVENT', 'EVENT_ART', 'EVENT_LITERATURE', 'MOVIE_EVENT'
      self.display_category = 'Arts'
    when 'SPORTS_EVENT', 'FITNESS'
      self.display_category = 'Athletic'
    when 'NETWORKING'
      self.display_category = 'Career and Professional'
    when 'EVENT_CAUSE', 'CAUSES'
      self.display_category = 'Causes'
    when 'FUNDRAISER', 'VOLUNTEERING'
      self.display_category = 'Charity and Community Service'
    when 'CONFERENCE_EVENT', 'MEETUP', 'WORKSHOP'
      self.display_category = 'Conferences, Meetings and Workshops'
    when 'COMMUNITY'
      self.display_category = 'Ethnic and Cultural'
    when 'EVENT_FOOD', 'FOOD_DRINK', 'FOOD_TASTING', 'DINING_EVENT'
      self.display_category = 'Food'
    when 'HEALTH_WELLNESS'
      self.display_category = 'Health and Wellness'
    when 'LECTURE'
      self.display_category = 'Lectures and Speakers'
    when 'FESTIVAL_EVENT', 'MUSIC', 'MUSIC_EVENT', 'COMEDY_EVENT', 'DANCE_EVENT', 'THEATER_EVENT', 'THEATER_DANCE'
      self.display_category = 'Music, Theater and Performances'
    when 'RELIGION', 'RELIGIOUS_EVENT'
      self.display_category = 'Religious and Spiritual'
    when 'NIGHTLIFE', 'PARTIES_NIGHTLIFE'
      self.display_category = 'Social'
    else
      self.display_category = 'Other'
    end
  end

  def fb?
    !fbID.empty?
  end

  def self.categories
    ['Academic', 'Arts', 'Athletic', 'Career and Professional', 'Causes',
     'Charity and Community Service', 'Conferences, Meetings and Workshops',
     'Ethnic and Cultural', 'Food', 'Health and Wellness',
     'Lectures and Speakers', 'Music, Theater and Performances', 'Political',
     'Religious and Spiritual', 'Social', 'Other']
  end
end
