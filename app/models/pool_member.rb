class PoolMember < ActiveRecord::Base
  has_many :skaters
  has_many :goalie
  belongs_to :pool

  def total_team_points
    (skaters.sum(:goals)*2) + skaters.sum(:assists) + (goalie.sum(:wins)*2) + (goalie.sum(:so)*3)
  end
end
