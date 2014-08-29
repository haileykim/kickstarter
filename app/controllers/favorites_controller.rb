class FavoritesController < ApplicationController

  before_action :set_project
  before_action :require_signin
  
  def create
  	@project.favorites.create!(user: current_user)
  	redirect_to @project
  end
  
  def destroy
    favorite = current_user.favorites.find(params[:id])
    favorite.destroy
    redirect_to @project
  end

private
  def set_project
  	@project = Project.find(params[:project_id])
  end

end
