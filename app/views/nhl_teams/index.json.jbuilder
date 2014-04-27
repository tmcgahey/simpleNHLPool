json.array!(@nhl_teams) do |nhl_team|
  json.extract! nhl_team, :id, :name, :references, :active
  json.url nhl_team_url(nhl_team, format: :json)
end
