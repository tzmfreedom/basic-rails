class User < ActiveRecord::Base
  acts_as_authentic

  def update_password(params)
    self.password = params[:password]
    self.password_confirmation = params[:password_confirmation]
    save
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.reset_password(self).deliver_now
  end
end
