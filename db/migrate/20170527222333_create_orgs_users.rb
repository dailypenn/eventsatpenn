class CreateOrgsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :orgs_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :org, index: true
      t.timestamps
    end
  end
end
