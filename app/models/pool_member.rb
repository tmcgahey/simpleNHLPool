class PoolMember < ActiveRecord::Base
  belongs_to :pool
  has_many :skaters
  has_many :goalies

  def total_team_points
    (skaters.sum(:goals)*2) + skaters.sum(:assists)
  end
end
