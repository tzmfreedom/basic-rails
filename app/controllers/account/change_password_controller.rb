module Account
  class ChangePasswordController < ApplicationController
    def new

    end

    def create
      if current_user.update_password(password: params[:password], password_confirmation: params[:password])
      else
      end
    end
  end
end
