class UsersController < ApplicationController
  before_action :require_login, only: [:show, :update]

  def new
    @form= UserRegisterForm.new
    auth = session["omniauth.#{params[:provider]}_data"]
    @form.email = SocialProfile.build_parameter(auth).email if auth.present?
  end

  def update
    @user = current_user
    if @user.update(user_params)
      render :show, notice: 'ユーザ情報を更新しました！'
    else
      render :show
    end
  end

  def create
    @form = UserRegisterForm.new(user_register_form_params)
    if @form.save
      redirect_to complete_users_url
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  def complete
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_register_form_params
    user_register_params = params.require(:user_register_form)
                               .permit(:email, :password, :password_confirmation)
    auth = session["omniauth.#{params[:provider]}_data"]
    user_register_params.merge(auth: auth) if auth.present?
  end
end
