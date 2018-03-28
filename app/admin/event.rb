ActiveAdmin.register Event do
  permit_params Event.attribute_names.map(&:to_sym) # All attributes

  # Index Page
  index do
    selectable_column
    id_column
    column :title
    column :start_date
    column :org
    column :featured
    column :created_at
    column :sponsored, :toggle
    actions
  end

  # Index filters
  filter :org
  filter :title
  filter :start_date
  filter :end_date
  filter :description
  filter :location
  filter :category

  # Show page
  # just show everything

  # form
  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :org
      f.input :title
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
      f.input :event_date, as: :datepicker
      f.input :all_day
      f.input :description
      f.input :location
      f.input :location_lat
      f.input :location_lon
      f.input :category
      f.input :display_category, as: :select, collection: Event.categories
      f.input :fbID
      f.input :twentyone
      f.input :recurring
      f.input :recurrence_freq
      f.input :recurrence_amt
      f.input :featured
      f.input :featured_snippet
      f.input :sponsored, :toggle
    end
    f.actions
  end
end
