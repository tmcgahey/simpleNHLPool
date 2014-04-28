class AddNhlTeamToGoalie < ActiveRecord::Migration
  def change
    add_reference :goalies, :nhl_team, index: true
  end
end
