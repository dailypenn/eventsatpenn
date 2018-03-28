class AddSponsoredToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :sponsored, :boolean
  end
end
