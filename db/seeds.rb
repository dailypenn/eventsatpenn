# This file should contain all the record creation needed to seed the database
# with test values. The data can then be loaded with the rails db:seed command
# (or created alongside the database with db:setup).

if Rails.env.development?
  today = Time.current.beginning_of_day

  cc = Org.create!(
    name: 'Cat Club',
    bio: 'We are a club for all cat lovers. We really like cats.',
    fbID: nil,
    category: 'Animals',
    website: 'http://www.omgcatsinspace.com/',
    photo_url: 'http://www.placecage.com/250/250.png'
  )

  hp = Org.create!(
    name: 'The Hourly Pennsylvanian',
    bio: 'An hourly newspaper for the Penn community.',
    fbID: nil,
    category: 'News',
    website: 'http://www.omgcatsinspace.com/',
    photo_url: 'http://www.placecage.com/251/251.png'
  )

  bc = Org.create!(
    name: 'Bain Capital',
    bio: 'For some reason all you kids want to work at our company. We\'re still
          trying to figure out why',
    fbID: nil,
    category: 'Company',
    website: 'http://www.omgcatsinspace.com/',
    photo_url: 'http://www.placecage.com/253/253.png'
  )

  Event.create!(
    title: 'Cat adoption day',
    description: 'Come meet and adopt cats from around the Philly area.',
    event_date: today,
    all_day: true,
    location: 'Houston Hall',
    org: cc,
    category: 'Publications'
  )

  Event.create!(
    title: 'Hour with a Pennsylvanian',
    description: 'You can meet with a pennsylvanian for exactly one hour.
                  No exceptions.',
    start_date: today + 8.hours,
    end_date: today + 9.hours,
    all_day: false,
    location: '4015 Walnut Street',
    org: hp,
    category: 'Publications'
  )
end
