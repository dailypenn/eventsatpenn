# This file should contain all the record creation needed to seed the database
# with test values. The data can then be loaded with the rails db:seed command
# (or created alongside the database with db:setup).

if Rails.env.development?
  today = Time.current.beginning_of_day + 9.hours

  (1..10).each do |i|
    Org.create!(
      name: "Organization #{i}",
      bio: "This is the bio for Organnization # #{i}",
      fbID: nil,
      category: 'Category',
      website: 'http://www.example.com/',
      photo_url: 'http://www.placecage.com/250/250.png'
    )
  end

  (1..40).each do |i|
    org = Org.all.sample
    offset = rand(1..20).days
    hr_offset = rand(1...7).hours
    category = [
      'Academic',
      'Athletic',
      'Career and Professional',
      'Charity and Community Service',
      'Ethnic and Cultural',
      'Food',
      'Music, Theater and Performances'
    ].sample
    Event.create!(
      title: "Event #{i}",
      description: "Do something at this event #{i}",
      start_date: today + offset + hr_offset,
      end_date: today + offset + hr_offset + 1.hour,
      all_day: false,
      location: '4015 Walnut Street',
      org: org,
      category: category
    )
  end
end
