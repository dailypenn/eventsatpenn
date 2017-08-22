class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    set_meta_tags og: {
      title: 'Events | Events@Penn',
      type:  'website',
      image: ''
    }
    if params['start_date']
      min = Date.parse(params['start_date'])
      max = Date.parse(params['start_date']) + 1.day
      @events = Event.where('start_date >= ? AND end_date < ?', min, max)
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
    set_meta_tags og: {
      title: "#{@event.title} on Events@Penn",
      type:  'website',
      image: @event.org.photo_url
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
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :fbID, :start_date, :end_date, :event_date, :description, :location, :category, :twentyone, :recurring, :recurrence_freq, :recurrence_amt, :all_day, :org)
  end
end
