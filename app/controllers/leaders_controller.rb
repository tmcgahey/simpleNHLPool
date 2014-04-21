class LeadersController < ApplicationController

  def index
    @pool_members = Pool.find(session[:pool_id]).pool_members
    @sorted_pool_members = @pool_members.sort_by { |pool_member| pool_member.total_team_points}.reverse
  end

  def updateSkaters

    playoff_teams.each do |team|
      @response = RestClient.get 'http://nhlwc.cdnak.neulion.com/fs1/nhl/league/playerstatsline/20132014/3/' + team + '/iphone/playerstatsline.json'

      @json_response = ActiveSupport::JSON.decode(@response)

      @json_response["skaterData"].each do |skater|
        @skater_data = skater["data"].split(/,/)

        Skater.find_or_create_by(nhl_id: skater["id"]) do |s|
          s.name = @skater_data[2]
          s.pos = @skater_data[1]
          s.goals = @skater_data[4]
          s.assists = @skater_data[5]
          s.team = team
        end

      end

      @json_response["goalieData"].each do |goalie|
        @goalie_data = goalie["data"].split(/,/)

        Goalie.find_or_create_by(nhl_id: goalie["id"]) do |g|
          g.name = @goalie_data[2]
          g.team = team
          g.wins = @goalie_data[4]
          g.so = @goalie_data[12]
        end
      end

    end

    respond_to do |format|
      format.html { redirect_to leaders_path, notice: "Skater data updated" }
      format.json { head :no_content }
    end

  end

  def show
    @pool_member = PoolMember.find(params[:id])
  end

  private
    def playoff_teams
      @playoff_teams = ["DAL","ANA","MTL","TBL","DET","BOS","PHI","NYR","CHI","STL","MIN","COL","LAK","SJS","PIT","CBJ"]
    end
end
