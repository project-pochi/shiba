class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(encrypted_email_address: params[:session][:encrypted_email_address])

    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        remember user
        redirect_to user
      else
        message = "Account not activated."
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
