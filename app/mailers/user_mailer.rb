class UserMailer < ActionMailer::Base
  default :from => "amer@amerj.info"

  def welcome_email(user)
    @user = user
    @url  = "http://amerj.info"
    mail(:to => user.email,
      :subject => "Welcome to My Awesome Site")
  end
end
