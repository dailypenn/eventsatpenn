class AddDefaultCategoryToEvents < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :category, :string, defaut: 'OTHER'
  end
end
