class EmailVerifyController < ApplicationController
  def show
    user = User.find_by!(email: params[:email])
    if user.email_verify_token_expired?
      render :show, alert: 'URLの有効期限が切れています。確認用メール送信画面から再度メールを送信してください。' and return
    end

    if user.verify_email(params[:id])
      reset_session
      session[:user_id] = user.id
      redirect_to new_obet_url, notice: 'ユーザ登録が完了しました'
    else
      render :show, alert: 'ユーザ登録に失敗しました。問い合わせフォームからお問い合わせください。'
    end
  end
end