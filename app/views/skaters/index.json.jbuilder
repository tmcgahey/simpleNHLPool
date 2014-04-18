json.array!(@skaters) do |skater|
  json.extract! skater, :id, :name, :team, :pos, :goals, :assists, :pool_member_id
  json.url skater_url(skater, format: :json)
end
