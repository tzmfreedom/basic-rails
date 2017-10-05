class LoginForm
  include ::ActiveModel::Model

  attr_accessor :email, :password, :user

  delegate :id, to: :user, prefix: :user

  validates :email, presence: true
  validates :password, presence: true

  INVALID_CREDENTIAL_ERROR = "メールアドレスあるいはパスワードが正しくありません。\n入力内容を確認して再度ログインしてください。"

  def authenticate
    return false if invalid?

    self.user = User.find_by(email: email)
    if user.nil? || user.password_digest.nil? || !user.active?
      errors[:base] << ::LoginForm::INVALID_CREDENTIAL_ERROR
      return false
    end

    unless user.authenticate(password)
      errors[:base] << ::LoginForm::INVALID_CREDENTIAL_ERROR
      return false
    end

    true
  end
end