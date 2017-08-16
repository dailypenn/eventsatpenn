class Org < ApplicationRecord
  require 'uri'

  filterrific(
    available_filters: [
      :search_query,
      :with_category
    ]
  )

  has_and_belongs_to_many :users
  has_many :events
  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validate :valid_website?
  validate :valid_photo?

  scope :search_query, lambda { |query|
    return nil if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # bracket with '%' to search anywhere in org name
    terms = terms.map { |term| '%' + term + '%' }
    # SQL query
    where(
      terms.map { 'LOWER(orgs.name) LIKE ?' }.join(' AND '),
      *terms.map { |e| [e] }.flatten
    )
  }

  scope :with_category, lambda { |categories|
    where(category: [*categories])
  }

  def valid_website?
    return if website.empty?
    uri = URI.parse(website)
    errors.add(website, 'is not a valid URL.') unless uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def valid_photo?
    return true if photo_url.nil?
    uri = URI.parse(photo_url)
    if uri.path
      # supported image types are png and jpg/jpeg
      errors.add(photo_url, 'is not a valid image URL. Supported image types are png, jpg, and jpeg.') unless uri.is_a?(URI::HTTP) && !uri.host.nil? && uri.path.match(/\.(png|jpg|jpeg)\Z/i)
    else
      errors.add(photo_url, 'is not a valid image URL.')
    end
  rescue URI::InvalidURIError
    false
  end

  def fb?
    fbID?
  end

  # TODO: dummy categories
  def self.categories
    %w(Arts Sports Publications)
  end
end
