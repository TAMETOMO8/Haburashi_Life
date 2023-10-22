class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  add_flash_types :primary, :success, :info, :warning, :danger

  private

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    !!current_user
  end
end
