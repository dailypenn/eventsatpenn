class CreateOrgs < ActiveRecord::Migration[5.1]
  def change
    create_table :orgs do |t|
      t.string :name, null: false
      t.string :bio
      t.string :fbID
      t.string :category, null: false
      t.string :website
      t.string :photo_url

      t.timestamps
    end
  end
end
