ActiveAdmin.register Org do

  # Index Page
  index do
    selectable_column
    id_column
    column :name
    column :created_at
    actions
  end

  # Index filters
  filter :name
  filter :category
  filter :website

  # Show page
  # just show everything

  # form
  # just show everything
end
