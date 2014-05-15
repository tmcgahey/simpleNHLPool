class PoolMember < ActiveRecord::Base
  has_many :skaters
  has_many :goalie
  belongs_to :pool

  def total_team_points
    (skaters.sum(:goals)*2) + skaters.sum(:assists) + (goalie.sum(:wins)*2) + (goalie.sum(:so)*3) + (goalie.sum(:goals)*2) + goalie.sum(:assists)
  end

  def total_goals
    skaters.sum(:goals) + goalie.sum(:goals)
  end

  def total_assists
    skaters.sum(:assists) + goalie.sum(:assists)
  end

  def remaining_players
    @remainingSkaters = Skater.joins(:nhl_team).where('nhl_teams.active' => true,'skaters.pool_member_id' => self.id).count

    @team1 = NhlTeam.find_by(name: self.goalie1, pool_id: self.pool.id)
    @team2 = NhlTeam.find_by(name: self.goalie2, pool_id: self.pool.id)

    if(@team1 && @team1.active)
      @remainingSkaters += 1
    end

    if(@team2 && @team2.active)
      @remainingSkaters += 1
    end

    @remainingSkaters
  end

end
