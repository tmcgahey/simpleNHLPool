class PoolMember < ActiveRecord::Base
  has_many :skaters
  has_many :goalie
  belongs_to :pool

  def total_team_points
    (skaters.sum(:goals)*2) + skaters.sum(:assists) + (goalie.sum(:wins)*2) + (goalie.sum(:so)*3)
  end

  def remaining_players
    @remainingSkaters = Skater.joins(:nhl_team).where('nhl_teams.active' => true,'skaters.pool_member_id' => self.id).count
    @remainingGoalies = Goalie.joins(:nhl_team).where('nhl_teams.active' => true,'goalies.pool_member_id' => self.id).count

    @remainingSkaters + @remainingGoalies
  end

end
