class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :full_name
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :image_url

      t.timestamps
    end
  end
end