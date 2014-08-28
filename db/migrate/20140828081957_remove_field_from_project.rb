class RemoveFieldFromProject < ActiveRecord::Migration
  def up
  	remove_column :projects, :team_member
  end

  def down
    add_column :projects, :team_member, :string
  end
end
