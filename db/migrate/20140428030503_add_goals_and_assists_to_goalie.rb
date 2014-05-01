class AddGoalsAndAssistsToGoalie < ActiveRecord::Migration
  def change
    add_column :goalies, :goals, :integer
    add_column :goalies, :assists, :integer
  end
end
