class CreateSkaters < ActiveRecord::Migration
  def change
    create_table :skaters do |t|
      t.string :name
      t.string :team
      t.string :pos
      t.integer :goals
      t.integer :assists
      t.references :pool_member, index: true

      t.timestamps
    end
  end
end
