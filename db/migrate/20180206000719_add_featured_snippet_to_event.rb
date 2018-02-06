class AddFeaturedSnippetToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :featured_snippet, :string, :limit => 200
  end
end
