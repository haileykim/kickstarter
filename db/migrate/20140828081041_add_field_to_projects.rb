class AddFieldToProjects < ActiveRecord::Migration
  def up
  	Project.delete_all
  	add_column :projects, :user_id, :integer
  end

  def down
    Project.delete_all
    remove_column :projects, :user_id
  end
end
