ActiveAdmin.register Event do

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
