class AddMoreFieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :team_members, :string
  end
end
