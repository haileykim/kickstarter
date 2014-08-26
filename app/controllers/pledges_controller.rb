class PledgesController < ApplicationController
  before_action :set_project

  def new
    @pledge = @project.pledges.new
  end

  def create
  	@pledge = @project.pledges.new(pledge_params)
  	
  	if @pledge.save
  	  redirect_to @project, notice: 'Thank you for your pledge!'
  	else
  	  render :new
  	end
  end

private

  def set_project
  	@project = Project.find(params[:project_id])
  end

  def pledge_params
  	params.require(:pledge).permit(:amount, :name)
  end
end
