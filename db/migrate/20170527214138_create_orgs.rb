class CreateOrgs < ActiveRecord::Migration[5.1]
  def change
    create_table :orgs do |t|
      t.string :name
      t.string :tagline
      t.string :bio
      t.string :fbID
      t.string :category
      t.string :website
      t.string :photo_url

      t.timestamps
    end
  end
end
