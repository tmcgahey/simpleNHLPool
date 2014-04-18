class CreatePoolMembers < ActiveRecord::Migration
  def change
    create_table :pool_members do |t|
      t.string :name
      t.references :pool, index: true

      t.timestamps
    end
  end
end
