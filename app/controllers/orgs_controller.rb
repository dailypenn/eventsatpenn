class OrgsController < ApplicationController
  before_action :set_org, only: [:show, :edit, :update, :destroy]

  # GET /orgs
  # GET /orgs.json
  def index
    @filterrific = initialize_filterrific(
      Org,
      params[:filterrific],
      select_options: {
        with_category: Org.categories
      }
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
    # TODO: head's up this is broken
    ScrapeNewEventsJob.perform_later(@org, access_token) if @org.fb? && user_signed_in?
  end

  # GET /orgs/new
  def new
    @org = Org.new
  end

  def new_from_fb
    org_params = params['fb_page']
    @org = Org.new(name: org_params['name'], category: org_params['category'], fbID: org_params['id'])
  end

  # GET /orgs/1/edit
  def edit
  end

  # POST /orgs
  # POST /orgs.json
  def create
    @org = Org.new(org_params)
    ScrapeNewEventsJob.perform_now(@org, access_token) if @org.fb? && user_signed_in?

    respond_to do |format|
      if @org.save
        current_user.orgs << @org
        format.html { redirect_to @org, notice: "#{@org.name} was successfully created." }
        format.json { render :show, status: :created, location: @org }
      else
        format.html { render :new }
        format.json { render json: @org.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orgs/1
  # PATCH/PUT /orgs/1.json
  def update
    respond_to do |format|
      if @org.update(org_params)
        format.html { redirect_to @org, notice: "#{@org.name} was successfully updated." }
        format.json { render :show, status: :ok, location: @org }
      else
        format.html { render :edit }
        format.json { render json: @org.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orgs/1
  # DELETE /orgs/1.json
  def destroy
    @org.destroy
    respond_to do |format|
      format.html { redirect_to orgs_url, notice: "#{@org.name} was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_org
      @org = Org.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def org_params
      params.require(:org).permit(:name, :bio, :fbID, :category, :website, :photo_url)
    end
end
