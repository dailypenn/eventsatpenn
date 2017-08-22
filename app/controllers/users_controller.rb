class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user?, except: [:index]

  def index
    set_meta_tags og: {
      title: 'Users | Events@Penn',
      type:  'website',
      image: og_fallback
    }
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    set_meta_tags og: {
      title: "#{@user.full_name}'s Profile on Events@Penn",
      type:  'website',
      image: @user.image_url
    }
  end

  def fb_pages
    session[:user_hash]['extra']['raw_info']['accounts']['data']
  end
end
