class UsersController < ApplicationController

  # Show all users
  def index
    @users = User.all
  end

  # Show user by id
  def show
    @user = User.find(params[:id])
  end

  # Delete user
  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  # Edit user
  def edit
    @user = User.find(current_user.id)
  end

  # New users
  def new
  	@user = User.new
  end

  # Update user
  def update
    if !params[:user].nil?
      params[:strava_link] = params[:user][:strava_link]
    end
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.permit(:name, :racer_id, :strava_link)
  end
end