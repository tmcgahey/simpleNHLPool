class PoolMember < ActiveRecord::Base
  belongs_to :pool
  has_many :skaters

  def total_team_points
    (skaters.sum(:goals)*2) + skaters.sum(:assists)
  end
end
