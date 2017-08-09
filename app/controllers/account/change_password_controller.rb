module Account
  class ChangePasswordController < ApplicationController
    def new
      @user = User.new
    end

    def create
      if current_user.update_password(change_password_params)
      else
      end
    end

    private

    def change_password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
end
