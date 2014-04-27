class CreateNhlTeams < ActiveRecord::Migration
  def change
    create_table :nhl_teams do |t|
      t.string :name
      t.references :pool
      t.boolean :active

      t.timestamps
    end
  end
end
