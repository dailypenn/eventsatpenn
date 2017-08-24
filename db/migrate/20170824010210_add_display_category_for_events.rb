class AddDisplayCategoryForEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :display_category, :string
  end
end
