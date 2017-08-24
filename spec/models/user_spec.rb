require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users

  describe '#admin?' do
    it 'returns false when user is not admin' do
      snow = users(:john_snow)
      result = snow.admin?
      expect(result).to eq false
    end

    it 'returns true when user is admin' do
      cerc = users(:cersei_lannister)
      result = cerc.admin?
      expect(result).to eq true
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
