class UserMailer < ApplicationMailer

  def forgot_password_email
    @user = params[:user]
    @otp = params[:otp]
    mail(to: @user.email, subject: 'OTP for Reset Password')
  end

end
