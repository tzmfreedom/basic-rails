class UserMailer < ApplicationMailer

  def reset_password(user)
    @edit_password_reset_url = edit_account_reset_password_url(user.perishable_token)
    mail(
        to: user.email,
        subject: "Password Reset Instructions",
        from: "noreplay@freedom-man.com",
    )
  end

  def change_password(before_mail, after_mail)
    @after_mail = after_mail
    mail(
        to: before_mail,
        subject: "Password Change Instructions",
        from: "noreplay@freedom-man.com",
    )
  end
end
