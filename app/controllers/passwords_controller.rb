class PasswordsController < ApplicationController
  def new; end

  def create
    email = params[:email].to_s.downcase
    if (user = User.find_by(email: email))
      user.generate_password_reset!
      # In a production-ready setup, send mail here via a mailer.
      Rails.logger.info("Password reset link: #{edit_password_url(token: user.reset_password_token)}")
    end
    redirect_to login_path, notice: "If that email exists, we have sent reset instructions."
  end

  def edit
    @user = User.find_by(reset_password_token: params[:token])
    unless @user&.password_reset_period_valid?
      redirect_to new_password_path, alert: "Reset link is invalid or expired"
    end
  end

  def update
    @user = User.find_by(reset_password_token: params[:token])
    unless @user&.password_reset_period_valid?
      return redirect_to new_password_path, alert: "Reset link is invalid or expired"
    end
    if params[:password].blank?
      flash.now[:alert] = "Password cannot be blank"
      return render :edit, status: :unprocessable_entity
    end
    if @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
      @user.clear_password_reset!
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Password has been reset"
    else
      flash.now[:alert] = @user.errors.full_messages.join(', ')
      render :edit, status: :unprocessable_entity
    end
  end
end

