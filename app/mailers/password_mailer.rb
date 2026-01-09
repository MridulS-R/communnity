class PasswordMailer < ApplicationMailer
  def reset_email(user)
    @user = user
    @reset_url = edit_password_url("reset", token: user.reset_password_token)
    mail to: user.email, subject: "Reset your Communnity password"
  end
end

