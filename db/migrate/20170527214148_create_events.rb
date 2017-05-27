class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.time :start_time
      t.time :end_time
      t.string :description
      t.string :location
      t.string :category
      t.boolean :twentyone
      t.boolean :recurring
      t.string :recurrence_freq
      t.integer :recurrence_amt

      t.timestamps
    end
  end
end
