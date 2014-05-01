namespace :nhlpool do
  desc "TODO"
  task :linktoteam => :environment do
    @pool = Pool.find_by(name: 'DKNHL2014')

    @pool.nhl_teams.each do |team|

      Skater.where(team: team.name).each do |skater|
        skater.update(nhl_team_id: team.id)
      end

      Goalie.where(team: team.name).each do |goalie|
        goalie.update(nhl_team_id: team.id)
      end

    end

  end

  desc "Delete all goalies"
  task :deleteAllGoaliesAndSkaters => :environment do
    Goalie.delete_all
    Skater.delete_all
  end

  desc "update team names"
  task :updateTeamNames => :environment do
    @nhlteam = NhlTeam.find_by(name: 'CBJ')
    if @nhlteam != nil
      @nhlteam.update(name: 'CLB')
    end

    @nhlteam = NhlTeam.find_by(name: 'LAK')
    if @nhlteam != nil
      @nhlteam.update(name: 'LA')
    end

    @nhlteam = NhlTeam.find_by(name: 'SJS')
    if @nhlteam != nil
      @nhlteam.update(name: 'SJ')
    end

    @nhlteam = NhlTeam.find_by(name: 'TBL')
    if @nhlteam != nil
      @nhlteam.update(name: 'TB')
    end
  end
end
