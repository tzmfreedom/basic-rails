class UserMailer < ApplicationMailer
  def email_confirmation(user: , token: )
    @token = token
    @user = user
    mail(
        to: @user.email,
        subject: "Confirm Registration",
        from: "noreply@freedom-man.com"
    )
  end

  def reset_password(user)
    mail(
        to: user.email,
        subject: "Password Reset Instructions",
        from: "noreply@freedom-man.com",
    )
  end

  def change_password(before_mail, after_mail)
    @after_mail = after_mail
    mail(
        to: before_mail,
        subject: "Password Change Instructions",
        from: "noreply@freedom-man.com",
    )
  end
end
