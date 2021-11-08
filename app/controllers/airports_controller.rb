class AirportsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :show]
  before_action :set_airport, only: %i[ show edit update destroy ]

  # GET /airports or /airports.json
  def index
    if params[:set_locale]
      redirect_to airports_url(locale: params[:set_locale])
    else
      @airports = Airport.all
    end
  end

  # GET /airports/1 or /airports/1.json
  def show
    if params[:set_locale]
      redirect_to airports_url(locale: params[:set_locale])
    end
  end

  # GET /airports/new
  def new
    if params[:set_locale]
      redirect_to new_airport_url(locale: params[:set_locale])
    end
    @airport = Airport.new
  end

  # GET /airports/1/edit
  def edit
  end

  # POST /airports or /airports.json
  def create
    @airport = Airport.new(airport_params)

    respond_to do |format|
      if @airport.save
        format.html { redirect_to @airport, notice: "Airport was successfully created." }
        format.json { render :show, status: :created, location: @airport }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @airport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /airports/1 or /airports/1.json
  def update
    respond_to do |format|
      if @airport.update(airport_params)
        format.html { redirect_to @airport, notice: "Airport was successfully updated." }
        format.json { render :show, status: :ok, location: @airport }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @airport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /airports/1 or /airports/1.json
  def destroy
    @airport.destroy
    respond_to do |format|
      format.html { redirect_to airports_url, notice: "Airport was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_airport
      @airport = Airport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def airport_params
      params.require(:airport).permit(:icao, :name, :description, :fir, :coordinates, :iata, :logo)
    end
end
