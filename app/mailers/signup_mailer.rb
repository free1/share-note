#encoding: utf-8
class SignupMailer < ActionMailer::Base
  default from: "from@example.com"

  def send_signup_mailer(user)
  	@user = user
  	mail to: user.email, subject: "欢迎注册share note"
  end
end
