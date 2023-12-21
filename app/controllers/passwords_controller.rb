class PasswordsController < ApplicationController

  before_action :set_user, only: [:edit_password, :update_password]
  before_action :current_login, only: [:edit_password, :update_password]
  skip_before_action :require_user, only: [:new, :create, :enter_otp, :verify_otp, :reset_password]

  def edit_password

  end

  def update_password
    if current_user&.authenticate(params[:current_password])
      if current_user.update(password: params[:new_password])
        flash[:notice] = "Your password updated successfully!"
        redirect_to current_user
      else
        flash[:alert] = "Failed to update password."
        render 'edit_password'
      end
    else
      flash[:alert] = "Your old password does not match!"
      render 'edit_password'
    end
  end


  def new
    
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user
      otp = generate_otp
      session[:current_time] = Time.now
      UserMailer.with(user: @user, otp: otp).forgot_password_email.deliver_now
      session[:otp] = otp
      session[:user_email] = params[:email]
      redirect_to enter_otp_passwords_path
    else
      flash[:alert] = "Email not found. Please check and try again."
      redirect_to root_path
    end
  end

  def enter_otp
    
  end

  def verify_otp
    
    if params[:otp].to_i == session[:otp].to_i
       current_time =   Time.parse(session[:current_time]).to_i
       two_minutes_later = current_time + (2 * 60)
       new_time = Time.now
       if new_time >= two_minutes_later
         flash[:alert] = "Your OTP has expired!"
         render 'new'
       else
        render 'reset_password'
       end
    else
      flash[:alert] = 'Invalid OTP. Please try again.'
      render 'enter_otp'
    end
  end

  def reset_password

    @user = User.find_by(email: session[:user_email])

    if @user
      @user.password = params[:password]
      if @user.save
        flash[:notice] = "Your password updated successfully!!"
        redirect_to root_path
      else
        flash[:alert] = "There was an error updating your password."
        redirect_to root_path
      end
    else
      flash[:alert] = "User not found."
      render 'new' 
    end

  end

  private 

  def set_user
    @user = User.find(params[:id])
  end

  def current_login
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can edit only your account"
      redirect_to @user
    end
  end

  def generate_otp
    rand(1111..9999)
  end

end
