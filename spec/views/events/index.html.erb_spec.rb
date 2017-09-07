require 'rails_helper'

RSpec.describe 'events/index', type: :view do
  fixtures :orgs, :events

  before(:each) do
    cc = orgs(:cat_club)
    @events = [
      Event.create(
        title: 'Cat Adoption', description: 'Come to adopt a kitty!',
        start_date: Time.now + 1.hour, end_date: Time.now + 5.hours,
        event_date: Time.now, all_day: false, location: '4015 Walnut Street',
        location_lat: nil, location_lon: nil, org: cc, category: 'Publications'
      ),
       Event.create(
         title: 'Cat Party', description: 'woohoo!',
         start_date: Time.now - 10.days - 5.hours, end_date: Time.now - 10.days,
         event_date: Time.now - 10.days,
         all_day: false, location: '4015 Walnut Street', location_lat: nil,
         location_lon: nil, org: cc, category: 'Publications'
       )
     ]
  end

  it 'displays all the events' do
    render
    expect(rendered).to have_content 'Cat Adoption'
    expect(rendered).to have_content 'Cat Club'
  end

  it 'does not display previous events' do
    render
    expect(rendered).not_to have_content 'Cat Party by The Cat Club'
  end
end
