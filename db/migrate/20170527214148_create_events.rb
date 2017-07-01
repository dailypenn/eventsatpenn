class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.string :description
      t.string :location
      t.string :category
      t.boolean :twentyone
      t.boolean :recurring
      t.string :recurrence_freq
      t.integer :recurrence_amt
      t.belongs_to :org
      t.timestamps
    end
  end
end
