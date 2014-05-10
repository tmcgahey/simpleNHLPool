class LeadersController < ApplicationController

  def index
    @pool_members = Pool.find(session[:pool_id]).pool_members
    @sorted_pool_members = @pool_members.sort_by { |pool_member| pool_member.total_team_points}.reverse
    @pool = Pool.find(session[:pool_id])
  end

  def updateSkaters

    @pool = Pool.find(session[:pool_id])

    @skater_response = RestClient.get 'http://www2.tsn.ca/datafiles/JSON/NHL/NHL_STATS_SKATERS.js?c=1'
    @skaterData = @skater_response.split('?')[1].gsub!('[]','{"skater"').gsub!(';','}').gsub!("'",'"')

    @json_skater = ActiveSupport::JSON.decode(@skaterData)

    @json_skater["skater"].each do |skater|
      if skater[22] == 3
        @nhlteamid = NhlTeam.find_by(name: skater[2],pool_id: @pool.id).id

        @upsertSkater = Skater.find_or_create_by(name: skater[1],team: skater[2]) do |s|
          s.name = skater[1]
          s.pos = skater[0]
          s.goals = skater[5]
          s.assists = skater[6]
          s.team = skater[2]
          s.nhl_team_id = @nhlteamid
        end

        @upsertSkater.update(name: skater[1],pos: skater[0],goals: skater[5],assists: skater[6],team: skater[2],nhl_team_id: @nhlteamid)
      end
    end

    @goalie_response = RestClient.get 'http://www2.tsn.ca/datafiles/JSON/NHL/NHL_STATS_GOALIES.js?c=1'
    @goalieData = @goalie_response.split('?')[1].gsub!('[]','{"goalie"').gsub!(';','}').gsub!("'",'"')

    @json_goalie = ActiveSupport::JSON.decode(@goalieData)

    @json_goalie["goalie"].each do |goalie|
      if goalie[24] == 3
        @nhlteamid = NhlTeam.find_by(name: goalie[1],pool_id: @pool.id).id

        @upsertGoalie = Goalie.find_or_create_by(name: goalie[0],team: goalie[1]) do |g|
          g.name = goalie[0]
          g.team = goalie[1]
          g.wins = goalie[10]
          g.so = goalie[8]
          g.goals = goalie[16]
          g.assists = goalie[17]
          g.nhl_team_id = @nhlteamid
        end

        @upsertGoalie.update(name: goalie[0], team: goalie[1], wins: goalie[10],so: goalie[8],goals: goalie[16],assists: goalie[17],nhl_team_id: @nhlteamid)
      end
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

    respond_to do |format|
      format.html { redirect_to leaders_path, :flash => {:success => "Skater data has been updated" }}
      format.json { head :no_content }
    end

  end

  def show
    @pool_members = Pool.find(session[:pool_id]).pool_members
    @pool_member = PoolMember.find(params[:id])
  end

  private
    def playoff_teams
      @playoff_teams = ["DAL","ANA","MTL","TB","DET","BOS","PHI","NYR","CHI","STL","MIN","COL","LA","SJ","PIT","CLB"]
    end
end

