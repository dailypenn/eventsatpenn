class EventsController < ApplicationController
  before_action :logged_in?, only: %i[new create edit update destroy]
  before_action :set_event, only: %i[show edit update destroy]

  # GET /events
  # GET /events.json
  def index
    default_og_params('Events')
    if params['start_date']
      min = Date.parse(params['start_date'])
      max = Date.parse(params['start_date']) + 1.day
      @events = Event.where('(start_date BETWEEN ? AND ?) OR (end_date BETWEEN ? AND ?) OR (start_date < ? AND end_date >= ?)', min, max, min, max, min, max)
    else
      @events = Event.where('end_date >= ?', Time.new) # only future events

      @filterrific = initialize_filterrific(
        Event,
        params[:filterrific],
        select_options: {
          with_category: Event.categories
        }
      ) || return
      @events = @filterrific.find.sort_by(&:title)

      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    meta_img = @event.org.photo_url.nil? ? og_fallback : @event.org.photo_url
    set_meta_tags og: {
      title: "#{@event.title} on Events@Penn",
      type:  'website',
      image: meta_img
    }
    set_meta_tags twitter: {
      card: 'summary',
      title: "#{@event.title} on Events@Penn",
      image: meta_img
    }
  end

  # GET /events/new
  def new
    @event = Event.new
    render layout: 'calendar'
  end

  # GET /events/1/edit
  def edit; end

  # POST /events
  # POST /events.json
  def create
    new_event_params = event_params
    new_event_params['org'] = Org.find(event_params['org'])
    new_event_params['location_lat'] = params['lat']
    new_event_params['location_lon'] = params['lng']

    @event = Event.new(new_event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "#{@event.title} was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    new_event_params = event_params
    new_event_params['org'] = Org.find(event_params['org'])

    respond_to do |format|
      if @event.update(new_event_params)
        format.html { redirect_to @event, notice: "#{@event.title} was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "#{@event.title} was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    if Event.exists?(params[:id])
      @event = Event.find(params[:id])
    else
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :fbID, :start_date, :end_date, :event_date, :description, :location, :category, :twentyone, :recurring, :recurrence_freq, :recurrence_amt, :all_day, :org)
  end

  def logged_in?
    render file: 'public/403.html', status: :forbidden, layout: false unless user_signed_in?
  end
end
