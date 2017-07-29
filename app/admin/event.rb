ActiveAdmin.register Event do
  permit_params Event.attribute_names.map(&:to_sym) # All attributes

  # Index Page
  index do
    selectable_column
    id_column
    column :title
    column :start_date
    column :org
    column :created_at
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
  # just show everything
end
