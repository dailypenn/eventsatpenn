class AddFeaturedToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :featured, :boolean, :default => false
  end
end
