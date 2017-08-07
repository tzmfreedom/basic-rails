class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render :new
    else
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  private 
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
