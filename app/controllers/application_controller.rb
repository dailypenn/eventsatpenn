class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_fb_pages
  helper_method :access_token
  helper_method :user_signed_in?
  helper_method :correct_user?

  def index
    render :'welcome/index.html.erb', layout: 'calendar'
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue
    nil
  end

  def user_fb_pages
    session[:user_hash]['extra']['raw_info']['accounts']['data'] if user_signed_in?
  end

  def access_token
    session[:user_hash]['credentials']['token']
  end

  private

  def user_signed_in?
    return true if current_user
  end

  def correct_user?
    @user = User.find(params[:id])
    redirect_to root_url, alert: 'Access denied.' unless current_user == @user
  end

  def authenticate_user!
    redirect_to root_url, alert: 'Sign in for access.' unless current_user
  end

  def authenticate_admin_user!
    return false if current_user.nil?
    return unless current_user.admin?
    flash[:alert] = 'You are not an administrator.'
    redirect_to root_path
  end
end
