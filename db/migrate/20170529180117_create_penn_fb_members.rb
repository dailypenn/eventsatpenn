class CreatePennFbMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :penn_fb_members, id: false, primary_key: :fbID do |t|
      t.string :fbID
      t.string :name
    end
  end
end
