class OrgsController < ApplicationController
  before_action :logged_in?, only: %i[new create edit update destroy]
  before_action :set_org, only: %i[show edit update destroy]

  # GET /orgs
  # GET /orgs.json
  def index
    default_og_params('Organizations')
    @filterrific = initialize_filterrific(
      Org,
      params[:filterrific],
      select_options: { with_category: Org.categories }
    ) || return
    @orgs = @filterrific.find.sort_by(&:name)

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /orgs/1
  # GET /orgs/1.json
  def show
    @org = Org.find(params[:id])
    meta_img = @org.photo_url.nil? ? og_fallback : @org.photo_url
    set_meta_tags og: {
      title: "#{@org.name} on Events@Penn",
      type:  'website',
      description: @org.bio,
      image: meta_img
    }
    set_meta_tags twitter: {
      card: 'summary',
      title: "#{@org.name} on Events@Penn",
      image: meta_img
    }
    ScrapeNewEventsJob.perform_later(@org) if @org.fb? && user_signed_in?
  end

  # GET /orgs/new
  def new
    @org = Org.new
  end

  def new_from_fb
    org_params = params['fb_page']
    @org = Org.new(name: org_params['name'], category: org_params['category'],
                   fbID: org_params['id'], bio: org_params['about'],
                   website: org_params['website'],
                   photo_url: org_params['image_large'])
  end

  # GET /orgs/1/edit
  def edit; end

  # POST /orgs
  # POST /orgs.json
  def create
    @org = Org.new(org_params)

    if @org.save
      current_user.orgs << @org
      ScrapeNewEventsJob.perform_later(@org) if @org.fb? && user_signed_in?
      redirect_to @org, notice: "#{@org.name} was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /orgs/1
  # PATCH/PUT /orgs/1.json
  def update
    if @org.update(org_params)
      redirect_to @org, notice: "#{@org.name} was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /orgs/1
  # DELETE /orgs/1.json
  def destroy
    @org.destroy
    redirect_to orgs_url, notice: "#{@org.name} was successfully deleted."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_org
    if Org.exists?(params[:id])
      @org = Org.find(params[:id])
    else
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def org_params
    params.require(:org).permit(:name, :bio, :fbID, :category, :website, :photo_url)
  end

  def logged_in?
    render file: 'public/403.html', status: :forbidden, layout: false unless user_signed_in?
  end
end
