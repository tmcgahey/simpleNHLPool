class Goalie < ActiveRecord::Base
  belongs_to :pool_member

  def total_points
    self.wins*2 + self.so*3
  end
end
