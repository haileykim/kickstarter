class PledgesController < ApplicationController

  before_action :require_signin
  before_action :require_admin, only: [:destroy]
  
  before_action :set_project

  def new
    @pledge = @project.pledges.new
  end

  def create
  	@pledge = @project.pledges.new(pledge_params)
    @pledge.user = current_user
  	
  	if @pledge.save
  	  redirect_to @project, notice: 'Thank you for your pledge!'
  	else
  	  render :new
  	end
  end

  def destroy
    @pledge = @project.pledges.find(params[:id])
    @pledge.destroy
    redirect_to @project, notice: 'Pledge is deleted!'
  end


private

  def set_project
  	@project = Project.find(params[:project_id])
  end

  def pledge_params
  	params.require(:pledge).permit(:amount)
  end
end
