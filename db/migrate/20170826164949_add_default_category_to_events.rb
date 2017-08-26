class AddDefaultCategoryToEvents < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :category, :type, defaut: 'OTHER'
  end
end
