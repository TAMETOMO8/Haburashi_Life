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

  def require_login
    return if logged_in?

    redirect_to root_path, info: 'ログインしてください'
  end

  def skip_login
    return unless logged_in?

    redirect_to toothbrush_search_path, info: '既にログインしています'
  end
end
