class Pool < ActiveRecord::Base
  has_many :pool_members
  has_many :nhl_teams
end
