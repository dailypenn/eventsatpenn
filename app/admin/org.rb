ActiveAdmin.register Org do
  permit_params Org.attribute_names.map(&:to_sym) # All attributes

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
  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :name
      f.input :bio
      f.input :fbID
      f.input :category, as: :select, collection: Org.categories
      f.input :website
      f.input :photo_url
    end
    f.actions
  end
end
