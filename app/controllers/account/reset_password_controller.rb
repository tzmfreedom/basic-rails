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

    def edit
      @user = User.find_using_perishable_token(params[:id])
    end

    def update
      user = User.find_using_perishable_token(params[:id])
      if user
        user.update_password(change_password_params)
      end
    end

    private

    def change_password_params
      params.permit(:password, :password_confirmation)
    end
  end
end
