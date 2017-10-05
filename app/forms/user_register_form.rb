class UserRegisterForm
  include ::ActiveModel::Model

  attr_accessor :email, :password, :auth

  validate :validate_user

  def save
    return false if invalid?
    ActiveRecord::Base.transaction do
      user = build_user
      unless user.save
        user.errors.each do |attr, error|
          errors.add(attr, error)
        end
        return false
      end

      token = user.generate_confirm_token!
      UserMailer.email_confirmation(user: user, token: token).deliver_now
    end

    true
  end

  private

  def build_user
    if auth.present?
      user = User.new(email: email)
      params = SocialProfile.build_parameter(auth)
      user.social_profiles.build(provider: auth[:provider],
                                 uid: auth[:uid],
                                 nickname: params.nickname)
    else
      user = User.new(email: email, password: password, password_confirmation: password_confirmation)
    end
    user
  end

  def validate_user
    user = build_user
    if user.invalid?
      user.errors.each do |key, error|
        errors.add(key, error)
      end
    end
  end
end