class ResetPasswordController < ApplicationController
  before_action :check_token, only: [:edit, :update]

  def new
    @form = ResetPasswordForm.new
  end

  def create
    @form = ResetPasswordForm.new(reset_password_params)
    if @form.save
      redirect_to complete_reset_password_index_url and return
    end

    render :new
  end

  def edit
  end

  def update
    if @user.save(update_password_params)
      redirect_to root_url, notice: 'パスワードを更新しました' and return
    end

    render :edit
  end

  private

  def update_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def reset_password_params
    params.require(:reset_password_form).permit(:email)
  end

  def check_token
    @user = User.find_by!(email: params[:email])
    if @user.reset_password_token_expired? || !(@user.valid_reset_password_token?(params[:id]))
      redirect_to new_reset_password_url, alert: 'URLの有効期限が切れています。確認用メール送信画面から再度メールを送信してください。' and return
    end
  end
end
