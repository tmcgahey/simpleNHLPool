class CreateGoalies < ActiveRecord::Migration
  def change
    create_table :goalies do |t|
      t.string :name
      t.string :team
      t.integer :wins
      t.integer :so
      t.references :pool_member, index: true
      t.integer :nhl_id

      t.timestamps
    end
  end
end
