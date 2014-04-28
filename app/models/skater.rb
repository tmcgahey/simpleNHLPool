class Skater < ActiveRecord::Base
  belongs_to :pool_member
  belongs_to :nhl_team

  def total_points
    (self.goals*2) + self.assists
  end

end
