class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  private

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = session[:user_id] && User.find(session[:user_id])
    end
end
