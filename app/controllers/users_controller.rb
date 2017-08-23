class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user?, except: [:index]

  def show
    @user = User.find(params[:id])
    meta_img = @user.image_url.nil? ? og_fallback : @user.image_url
    set_meta_tags og: {
      title: "#{@user.full_name}'s Profile on Events@Penn",
      type:  'website',
      image: meta_img
    }
    set_meta_tags twitter: {
      card: 'summary',
      title: "#{@user.full_name}'s Profile on Events@Penn",
      image: meta_img
    }
  end

  def fb_pages
    session[:user_hash]['extra']['raw_info']['accounts']['data']
  end
end
