class User < ActiveRecord::Base
  acts_as_authentic

  def update_password(password:, password_confirmation: )
    self.password = password
    self.password_confirmation = password_confirmation
    update
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
end
