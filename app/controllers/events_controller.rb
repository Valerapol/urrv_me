class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]

  def index
    if params[:set_locale]
      redirect_to events_url(locale: params[:set_locale])
    elsif params[:icao]
      @airports = Airport.where('icao ILIKE ?', "%#{params[:icao]}%")
    else
      @events = Event.all
    end
  end

  def show
    if params[:set_locale]
      redirect_to events_url(locale: params[:set_locale])
    end
  end

  def new
    if params[:data]
      @event = Event.new(start_time: Date.parse(params[:data]), end_time: Date.parse(params[:data]))
    else
      @event = Event.new
    end
  end

  def edit
  end

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :body, :title_en, :body_en, :start_time, :end_time, :data)
    end
end
