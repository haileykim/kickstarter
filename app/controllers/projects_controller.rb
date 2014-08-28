class ProjectsController < ApplicationController

  before_action :require_signin, except: [:index, :show]

  def index
    @projects = Project.pledging
  end

  def show
    @project = Project.find(params[:id])
    @pledges = @project.pledges.order(created_at: :desc)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    @project.user = current_user

    if @project.save
      redirect_to @project, notice: 'Your project is successfully created!'
    else
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
    check_project_owner(@project)
  end

  def update
    @project = Project.find(params[:id])
    check_project_owner(@project)
  	if @project.update(project_params)
  	  redirect_to @project, notice: 'Your project is successfully edited!'
    else
      render 'edit'
    end 	
  end

  def destroy
    @project = Project.find(params[:id])
    check_project_owner(@project)
    @project.delete
    redirect_to root_path, notice: 'Your project is gone!'
  end

private
  def project_params
  	params.require(:project).permit(:name, :description, :target_pledge_amount, :website, :pledging_ends_on, :image)
  end

  def check_project_owner(project)
    redirect_to root_path unless current_user?(project.user)
  end

end
