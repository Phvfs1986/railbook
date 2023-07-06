# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'notifications@railbook.com'

  def welcome_email(user)
    @user = user
    @url = 'https://railbook.fly.dev/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to Railbook!')
  end
end
