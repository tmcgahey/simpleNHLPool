class LeadersController < ApplicationController

  def index
    @pool_members = Pool.find(session[:pool_id]).pool_members
    @sorted_pool_members = @pool_members.sort_by { |pool_member| pool_member.total_team_points}.reverse
  end

  def updateSkaters

    @pool = Pool.find(session[:pool_id])

    @pool.nhl_teams.each do |team|
      @response = RestClient.get 'http://nhlwc.cdnak.neulion.com/fs1/nhl/league/playerstatsline/20132014/3/' + team.name + '/iphone/playerstatsline.json'

      @json_response = ActiveSupport::JSON.decode(@response)

      @json_response["skaterData"].each do |skater|
        @skater_data = skater["data"].split(/,/)

        @upsertSkater = Skater.find_or_create_by(nhl_id: skater["id"]) do |s|
          s.name = @skater_data[2]
          s.pos = @skater_data[1]
          s.goals = @skater_data[4]
          s.assists = @skater_data[5]
          s.team = team.name
          s.nhl_team_id = team.id
        end
        @upsertSkater.update(name: @skater_data[2],pos: @skater_data[1],goals: @skater_data[4],assists: @skater_data[5],team: team.name,nhl_team_id: team.id)
      end

      @json_response["goalieData"].each do |goalie|
        @goalie_data = goalie["data"].split(/,/)

        @upsertGoalie = Goalie.find_or_create_by(nhl_id: goalie["id"]) do |g|
          g.name = @goalie_data[2]
          g.team = team.name
          g.wins = @goalie_data[4]
          g.so = @goalie_data[12]
          g.nhl_team_id = team.id
        end
        @upsertGoalie.update(name: @goalie_data[2], team: team.name, wins: @goalie_data[4],so: @goalie_data[12],nhl_team_id: team.id)
      end

      @pool_members = Pool.find(session[:pool_id]).pool_members

      @pool_members.each do |member|
        if member.goalie1.present?
          Goalie.where(team: member.goalie1).each do |goalie|
            goalie.update(pool_member_id: member.id)
          end
        end

        if member.goalie2.present?
          Goalie.where(team: member.goalie2).each do |goalie|
            goalie.update(pool_member_id: member.id)
          end

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
