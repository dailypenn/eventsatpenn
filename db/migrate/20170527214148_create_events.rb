class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :event_date
      t.boolean :all_day
      t.string :description
      t.string :location
      t.float :location_lat
      t.float :location_lon
      t.string :category
      t.string :fbID
      t.boolean :twentyone
      t.boolean :recurring
      t.string :recurrence_freq
      t.integer :recurrence_amt
      t.belongs_to :org
      t.timestamps
    end
  end
end
