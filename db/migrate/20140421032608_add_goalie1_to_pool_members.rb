class AddGoalie1ToPoolMembers < ActiveRecord::Migration
  def change
    add_column :pool_members, :goalie1, :string
    add_column :pool_members, :goalie2, :string
  end
end
