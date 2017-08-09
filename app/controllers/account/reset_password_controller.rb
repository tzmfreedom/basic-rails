module Account
  class ResetPasswordController < ApplicationController
    def new
      @user = User.new
    end

    def create
      user = User.find_by(email: params[:user][:email])
      if user
        user.deliver_password_reset_instructions!
      else
        # error
      end
      redirect_to root_url
    end

  end
end
