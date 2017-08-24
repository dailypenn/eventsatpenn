class PennFbMember < ApplicationRecord
  validates :fbID, :name, presence: true
end
