class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    if current_user
      current_user.create_social_profile(auth)
      redirect_to root_url and return
    end

    profile = SocialProfile.find_by_social_profile(auth)
    if profile.present?
      session[:user_id] = profile.user_id
      redirect_to root_url and return
    end

    session["omniauth.#{auth[:provider]}_data"] = auth
    redirect_to new_user_url(provider: auth[:provider])
  end
end
