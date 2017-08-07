class UserMailer < ApplicationMailer

  def reset_password(email)
    @greeting = "Hi"
    mail(
        to: email,
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
