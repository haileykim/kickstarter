class UsersController < ApplicationController
  before_action :require_correct_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: :index

  def index
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
    @projects = @user.projects.order(created_at: :desc)
    @pledges = @user.pledges.order(created_at: :desc)
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      session[:user_id] = @user.id
  	  redirect_to root_path, notice: 'Thank you for signing up!'
  	else 
  	  render :new
  	end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Your profile is successfully edited!'
    else
      render :edit
    end
  end

  def destroy
  	@user.destroy
    session[:user_id] = nil
  	redirect_to root_path, notice: 'Your account is deleted!'
  end


 private 
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end
end
