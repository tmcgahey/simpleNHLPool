class AddNhlTeamToSkaters < ActiveRecord::Migration
  def change
    add_reference :skaters, :nhl_team, index: true
  end
end
