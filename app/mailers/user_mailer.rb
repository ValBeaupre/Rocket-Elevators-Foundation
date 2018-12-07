class UserMailer < ApplicationMailer
    def welcome_email
    @user = params[:user]
    @url  = 'http://valbeaupre.com/login'
    mail(to: @user.email, subject: 'Welcome to Rocket Elevators')
  end


end
