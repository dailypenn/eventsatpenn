class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid, null: false
      t.string :full_name, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :image_url
      t.boolean :admin, null: false, default: false
      t.timestamps
    end
  end
end
