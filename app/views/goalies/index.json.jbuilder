json.array!(@goalies) do |goaly|
  json.extract! goaly, :id, :name, :team, :wins, :so, :pool_member_id, :nhl_id
  json.url goaly_url(goaly, format: :json)
end
