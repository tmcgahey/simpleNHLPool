json.array!(@pool_members) do |pool_member|
  json.extract! pool_member, :id, :name, :pool_id
  json.url pool_member_url(pool_member, format: :json)
end
