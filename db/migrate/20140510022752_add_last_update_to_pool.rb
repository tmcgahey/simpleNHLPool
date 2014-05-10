class AddLastUpdateToPool < ActiveRecord::Migration
  def change
    add_column :pools, :last_update, :datetime
  end
end
