class Org < ApplicationRecord
  filterrific(
    available_filters: [
      :search_query,
      :with_category
    ]
  )

  has_and_belongs_to_many :users
  has_many :events

  scope :search_query, lambda { |query|
    return nil if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    # terms = terms.map do |e|
    #   (e.tr('*', '%') + '%').tr(/%+/, '%')
    # end
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    # num_or_conditions = 3
    where(
      terms.map { 'LOWER(orgs.name) LIKE ?' }.join(' AND '),
      *terms.map { |e| [e] }.flatten
    )
  }

  scope :with_category, lambda { |categories|
    where(category: [*categories])
  }

  def fb?
    fbID?
  end

  def self.categories
    %w(Arts Sports)
  end
end
