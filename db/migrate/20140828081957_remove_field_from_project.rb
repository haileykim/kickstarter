class RemoveFieldFromProject < ActiveRecord::Migration
  def up
  	remove_column :projects, :team_members
  end

  def down
    add_column :projects, :team_members, :string
  end
end
