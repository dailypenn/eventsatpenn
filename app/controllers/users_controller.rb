class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user?, except: [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def fb_pages
    session[:user_hash]['extra']['raw_info']['accounts']['data']
  end
end
