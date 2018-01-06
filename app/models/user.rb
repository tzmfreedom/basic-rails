# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  nickname                     :string(255)
#  email                        :string(255)
#  password_digest              :string(255)
#  active                       :boolean          default(TRUE)
#  email_verified               :boolean          default(FALSE), not null
#  email_verify_token           :string(255)
#  email_verify_token_sent_at   :datetime
#  reset_password_token         :string(255)
#  reset_password_token_sent_at :datetime
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

class User < ActiveRecord::Base
  has_many :social_profiles

  has_secure_password validations: false

  validates :email, presence: true
  validates :email, uniqueness: true, length: { maximum: 255 }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def email_verify_token_expired?
    email_verify_token_sent_at < 1.day.ago
  end

  def reset_password_token_expired?
    reset_password_token_sent_at < 1.day.ago
  end

  def verify_email(token)
    return false if email_verified?
    return false if BCrypt::Password.new(email_verify_token) != token
    update(email_verified: true, email_verify_token: nil, email_verify_token_sent_at: nil)
  end

  def valid_reset_password_token?(token)
    BCrypt::Password.new(reset_password_token) == token
  end

  def generate_confirm_token!
    token = SecureRandom.urlsafe_base64.to_s
    update!(email_verify_token: BCrypt::Password.create(token),
            email_verify_token_sent_at: Time.zone.now)
    token
  end

  def generate_reset_password_token!
    token = SecureRandom.urlsafe_base64.to_s
    update!(reset_password_token: BCrypt::Password.create(token),
            reset_password_token_sent_at: Time.zone.now)
    token
  end

  def create_social_profile(params)
    social_profile = social_profiles.build
    social_profile.create_from!(params)
  end
end
