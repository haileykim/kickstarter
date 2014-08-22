class ProjectsController < ApplicationController

  def index
    @projects = Project.pledging
  end

  def show
    @project = Project.find(params[:id])
    @pledges = @project.pledges.order(created_at: :desc)
  end

  def edit
  	@project = Project.find(params[:id])
  end

  def update
  	@project = Project.find(params[:id])
  	if @project.update(project_params)
  	  redirect_to @project, notice: 'Your project is successfully edited!'
    else
      render 'edit'
    end 	
  end

  def new
  	@project = Project.new
  end

  def create
  	@project = Project.create(project_params)
  	if @project.save
  	  redirect_to @project, notice: 'Your project is successfully created!'
    else
      render 'new'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.delete
    redirect_to root_path, notice: 'Your project is gone!'
  end

private
  def project_params
  	params.require(:project).permit(:name, :description, :target_pledge_amount, :website, :pledging_ends_on, :team_members, :image)
  end


end
