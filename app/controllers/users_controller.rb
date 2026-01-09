class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome, #{@user.name}!"
    else
      flash.now[:alert] = @user.errors.full_messages.join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if params[:user][:password].present?
      unless @user.authenticate(params[:user][:current_password])
        flash.now[:alert] = "Current password is incorrect"
        return render :edit, status: :unprocessable_entity
      end
    end

    permitted = params.require(:user).permit(:name, :email, :company, :role, :password, :password_confirmation)
    permitted.delete(:password) if permitted[:password].blank?
    permitted.delete(:password_confirmation) if permitted[:password].blank?

    if @user.update(permitted)
      redirect_to account_path, notice: "Account updated"
    else
      flash.now[:alert] = @user.errors.full_messages.join(', ')
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :company, :role, :password, :password_confirmation)
  end
end
