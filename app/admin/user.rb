ActiveAdmin.register User do
  permit_params User.attribute_names.map(&:to_sym) # All attributes

  # Index Page
  index do
    selectable_column
    id_column
    column :email
    # column :current_sign_in_at
    # column :sign_in_count
    column :created_at
    actions
  end

  # Index filters
  filter :email
  filter :first_name
  filter :last_name
  filter :admin

  # Show page
  show title: :full_name do
    h3 user.full_name
    attributes_table do
      row :full_name
      row :admin
      row :email
      row :image do |user|
        image_tag user.image_url
      end
    end
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :full_name
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :image_url
      f.input :admin
    end
    f.actions
  end
end
