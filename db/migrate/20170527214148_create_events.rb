class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.datetime :event_date, null: false
      t.boolean :all_day, null: false, default: false
      t.string :description
      t.string :location, null: false
      t.float :location_lat
      t.float :location_lon
      t.string :category, null: false
      t.string :fbID
      t.boolean :twentyone, null: false, default: false
      t.boolean :recurring
      t.string :recurrence_freq
      t.integer :recurrence_amt
      t.belongs_to :org
      t.timestamps
    end
  end
end
