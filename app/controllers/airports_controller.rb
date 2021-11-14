class AirportsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :show]
  before_action :set_airport, only: %i[ show edit update destroy ]
  require "http"
  require 'json'
  require 'open-uri'
  def index
    if params[:set_locale]
      redirect_to airports_url(locale: params[:set_locale])
    end
    if params[:icao]
      @airports = Airport.where('icao ILIKE ?', "%#{params[:icao]}%")
    else
      @airports = Airport.all
    end
  end

  def show
    if params[:set_locale]
      redirect_to airport_url(locale: params[:set_locale])
    end

    #запрос metar taf
    metar = JSON.parse(HTTP.get("https://metartaf.ru/#{@airport.icao}.json").to_s)
    if metar.include?("error")
      @metar, @taf = "Нет данных"
    else
      m, t = metar["metar"].to_s.reverse!, metar["taf"].to_s.reverse!
      20.times do
        m.chop!
        t.chop!
      end
      @metar, @taf = m.reverse!, t.reverse!
    end
    #запрос notam
    if @airport.class_apt == "Международный"
      url_type = "http://caiga.ru/common/AirInter/series_notam/"
    elsif @airport.class_apt == "А, Б, В"
      url_type = "http://caiga.ru/common/AirClassABV/series_notam/"
    else
      url_type = "http://caiga.ru/common/AirClassGDE/to_notam_of_a_series_v/"
      url_type2 = "http://caiga.ru/common/AirClassGDE/to_notam_of_a_series_d/"
    end
    doc = Nokogiri::HTML(URI.open("#{url_type}"))
    url = doc.css('.table_left_df').map do |table|
      table_url = table['onclick'].to_s
      if @airport.class_apt == "Международный"
        87.times do table_url.chop! end
      elsif @airport.class_apt == "А, Б, В"
        90.times do table_url.chop! end
      else
        100.times do table_url.chop! end
      end
      table_url.reverse!
      47.times do table_url.chop! end
      table_url.reverse!
    end
    if @airport.class_apt == "Г, Д, Е"
      doc2 = Nokogiri::HTML(URI.open("#{url_type2}"))
      url2 = doc2.css('.table_left_df').map do |table|
        table_url = table['onclick'].to_s
        100.times do table_url.chop! end
        table_url.reverse!
        47.times do table_url.chop! end
        table_url.reverse!
      end
      url.push(url2)
    end
    url_parsed = []
    url.each do |str|
      if str.include?("_#{I18n.locale.to_s}")
        url_parsed.push(str)
      end
    end
    notam = []
    url_parsed.each do |url|
      url = "http://" + url
      doc_notam = URI.open("#{url}")
      doc_notam.each do |str|
        str = str.gsub("<br>", "").gsub("&nbsp;", " ").gsub("<html>", "").gsub("<head>", "").gsub("</html>", "").gsub("</head>", "").gsub("<font color=red>", "").gsub("</font>", "").chomp
        if str.include?("<")
          str
        else
          notam.push(str)
        end
      end
    end
    notam_parsed = ""
    notam_parsed_tr = ""
    @notam_arr = []
    notam.each do |el|
      if I18n.locale.to_s == "ru"
        el_tr = Translit.convert(el, :english)
      else
        el_tr = el
      end
      if el != "" and el_tr != "#{@airport.icao}:"
        notam_parsed += el
        notam_parsed_tr +=  el_tr
      else
        if notam_parsed == ""
          notam_parsed
        else
          if notam_parsed_tr.include?("A)#{@airport.icao}")
            @notam_arr.push(notam_parsed)
          end
        end
        notam_parsed = ""
        notam_parsed_tr = ""
      end
    end
  end

  def new
    if params[:set_locale]
      redirect_to new_airport_url(locale: params[:set_locale])
    end
    @airport = Airport.new
  end

  def edit
  end

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

  def destroy
    @airport.destroy
    respond_to do |format|
      format.html { redirect_to airports_url, notice: "Airport was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_airport
      @airport = Airport.friendly.find(params[:id])
    end

    def airport_params
      params.require(:airport).permit(:icao, :name, :description, :fir, :coordinates, :iata, :logo, :class_apt)
    end
end
