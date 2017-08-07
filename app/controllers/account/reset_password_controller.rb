module Account
  class ResetPasswordController < ApplicationController
    def new
    end

    def create
      user = User.find_by(email: params[:email])
      if user
        user.deliver_password_reset_instructions!
      else
        # error
      end
    end
  end
end
