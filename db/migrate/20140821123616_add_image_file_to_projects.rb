class AddImageFileToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :image_file_name, :string
  end
end
