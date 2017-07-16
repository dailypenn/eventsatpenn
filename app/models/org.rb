class Org < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :events

  def is_fb?
    fbID?
  end
end
