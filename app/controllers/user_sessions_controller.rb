class UserSessionsController < ApplicationController
  def new
    @login_form = LoginForm.new
  end

  def create
    @login_form = LoginForm.new(form_params)
    if @login_form.authenticate
      reset_session
      session[:user_id] = @login_form.user_id
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_url
  end

  private

  def form_params
    params.require(:login_form).permit(:email, :password)
  end
end
