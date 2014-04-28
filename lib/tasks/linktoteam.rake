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

end
