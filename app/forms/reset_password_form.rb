class ResetPasswordForm
  include ::ActiveModel::Model
  include ::ActiveModel::Validations

  attr_accessor :email

  validates :email, presence: true

  NO_USER_FOUND = "入力したメールアドレスのユーザが見つかりませんでした。\n入力内容をご確認の上、再度お試しください。"

  def save
    return false if invalid?

    user = User.find_by(email: email)
    if user.nil?
      errors[:base] << ::ResetPasswordForm::NO_USER_FOUND
      return false
    end

    token = user.generate_reset_password_token!
    UserMailer.reset_password(user: user, token: token).deliver_now
    true
  end
end