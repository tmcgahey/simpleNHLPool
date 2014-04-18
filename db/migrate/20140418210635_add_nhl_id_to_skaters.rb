class AddNhlIdToSkaters < ActiveRecord::Migration
  def change
    add_column :skaters, :nhl_id, :integer, index: true
    add_index "skaters", ["nhl_id"], name: "index_skaters_on_nhl_id"
  end
end
