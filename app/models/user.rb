# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  email               :string(255)
#  crypted_password    :string(255)
#  password_salt       :string(255)
#  persistence_token   :string(255)
#  single_access_token :string(255)
#  perishable_token    :string(255)
#  login_count         :integer          default(0), not null
#  failed_login_count  :integer          default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  active              :boolean          default(FALSE)
#  confirmed           :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

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
