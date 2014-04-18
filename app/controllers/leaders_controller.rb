class LeadersController < ApplicationController
  def index
    @pool_members = PoolMember.all
    @sorted_pool_members = @pool_members.sort_by { |pool_member| pool_member.total_team_points}.reverse
  end

  def updateSkaters

    respond_to do |format|
      format.html { redirect_to leaders_index_path }
      format.json { head :no_content }
    end

  end

end
