class Goalie < ActiveRecord::Base
  belongs_to :pool_member
  belongs_to :nhl_team

  def total_points
    self.wins*2 + self.so*3 + self.goals*2 + self.assists
  end
end
