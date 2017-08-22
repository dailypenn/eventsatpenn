class ApplicationController < ActionController::Base
  env = ENV.fetch('RAILS_ENV') { 'development' }
  before_action :set_raven_context if env == 'production'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  ###########################
  ##   Top Level Routing   ##
  ###########################

  def index
    @meta_description = %(
      Your guide to all the events Penn and Philly have to offer.
    )
    set_meta_tags og: {
      title: 'Events@Penn',
      url:   'http://www.eventsatpenn.com/',
      type:  'website',
      image: og_fallback
    }
    render :'welcome/index.html.erb', layout: 'calendar'
  end

  ###########################
  ## Global Helper Methods ##
  ###########################

  helper_method :current_user
  helper_method :user_fb_pages
  helper_method :access_token
  helper_method :user_signed_in?
  helper_method :correct_user?
  helper_method :mobile_device?
  helper_method :og_fallback

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue
    nil
  end

  def og_fallback
    ActionController::Base.helpers.image_path("og-fallback.png")
  end

  def user_fb_pages
    session[:user_hash]['extra']['raw_info']['accounts']['data'] if user_signed_in?
  end

  def access_token
    session[:user_hash]['credentials']['token']
  end

  private

  if env == 'production'
    def set_raven_context
      Raven.user_context(id: session[:user_hash])
      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end
  end

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
    current_user.admin?
  end

  def mobile_device?
    # The "98%" Solution for mobile user_agents https://git.io/v5fTp
    ua_regex = %(
      /Mobile|iP(hone|od|ad)|Android|BlackBerry|IEMobile|Kindle|NetFront|
      Silk-Accelerated|(hpw|web)OS|Fennec|Minimo|Opera M(obi|ini)|Blazer|Dolfin|
      Dolphin|Skyfire|Zune/
    )
    !request.user_agent.match(ua_regex).nil?
  end
end
