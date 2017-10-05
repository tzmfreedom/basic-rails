class EmailVerifyTokenController < ApplicationController
  def create
    token = current_user.generate_confirm_token!
    UserMailer.email_confirmation(user: current_user, token: token).deliver_now
  end
end