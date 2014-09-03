class CategoriesController < ApplicationController

before_action :set_category, only: [:show, :edit, :update, :destroy]
before_action :require_signin, except: [:index, :show]
before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.all
    @projects = Project.pledging
  end

  def show
    @projects = @category.projects   
  end

  def new
    @category = Category.new   
  end

  def create
    @category = Category.new(category_params)   
    if @category.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update

     if @category.update(category_params) 
      redirect_to root_path
    else
      render 'edit'
    end  
  end

  def destroy

    @category.destroy  
    redirect_to @root_path
  end

private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find_by!(slug: params[:id])
  end

end
