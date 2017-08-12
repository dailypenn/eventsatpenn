class SessionsController < ApplicationController
  def new
    redirect_to '/auth/facebook'
  end

  def create
    auth = request.env['omniauth.auth']
    user = User.where(provider: auth['provider'],
                      uid: auth['uid'].to_s).first || User.create_with_omniauth(auth)
    reset_session
    session[:user_id] = user.id
    session[:user_hash] = request.env['omniauth.auth']

    redirect_to root_url, notice: "Welcome, #{user.first_name}!"
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'You have successfully signed out.'
  end

  def failure
    redirect_to root_url, alert: "Authentication error: #{params[:message].humanize}"
  end
end
