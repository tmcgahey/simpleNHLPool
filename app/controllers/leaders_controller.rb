class LeadersController < ApplicationController

  def index
    @pool_members = PoolMember.all
    @sorted_pool_members = @pool_members.sort_by { |pool_member| pool_member.total_team_points}.reverse
  end

  def updateSkaters

    playoff_teams.each do |team|
      @response = RestClient.get 'http://nhlwc.cdnak.neulion.com/fs1/nhl/league/playerstatsline/20132014/3/' + team + '/iphone/playerstatsline.json'

      @json_response = ActiveSupport::JSON.decode(@response)

      @json_response["skaterData"].each do |skater|
        @skater_data = skater["data"].split(/,/)
        Skater.create(name: @skater_data[2], pos: @skater_data[1],
                      goals: @skater_data[4], assists: @skater_data[5],
                      nhl_id: skater["id"], team: team)
      end
    end


    respond_to do |format|
      format.html { redirect_to leaders_index_path, notice: "Skater data updated" }
      format.json { head :no_content }
    end

  end

  private
    def playoff_teams
      @playoff_teams = ["DAL","ANA","MTL","TBL","DET","BOS","PHI","NYR","CHI","STL","MIN","COL","LAK","SJS","PIT","CBJ"]
    end
end
