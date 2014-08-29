class ProjectsController < ApplicationController

  before_action :require_signin, except: [:index, :show]

  def index
    @projects = Project.pledging
  end

  def show
    @project = Project.find(params[:id])
    @pledges = @project.pledges.order(created_at: :desc)
    @backers = @project.backers
    @fans = @project.fans
    @categories = @project.categories

    if current_user
      @current_pledge = current_user.pledges.find_by(project_id: @project.id)
      @current_favorite = current_user.favorites.find_by(project_id: @project.id)
    end
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
    @project = current_user.projects.find(params[:id])
  end

  def update
    @project = current_user.projects.find(params[:id])
  	if @project.update(project_params)
  	  redirect_to @project, notice: 'Your project is successfully edited!'
    else
      render 'edit'
    end 	
  end

  def destroy
    @project = current_user.projects.find(params[:id])
    @project.delete
    redirect_to root_path, notice: 'Your project is gone!'
  end

private
  def project_params
  	params.require(:project).permit(:name, :description, :target_pledge_amount, :pledging_ends_on, :image, category_ids: [])
  end

end
