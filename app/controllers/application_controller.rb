class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    redirect_to login_path, alert: "Please log in" unless logged_in?
  end

  def require_admin
    unless logged_in? && current_user.admin?
      redirect_to login_path, alert: "Admin access required"
    end
  end
end
