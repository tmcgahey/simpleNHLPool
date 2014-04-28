class NhlTeam < ActiveRecord::Base
  belongs_to :pool
  has_many :skaters
end
