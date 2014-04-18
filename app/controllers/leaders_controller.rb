class LeadersController < ApplicationController
  def index
    @pool_members = PoolMember.all
  end
end
