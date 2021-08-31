class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def new
    @flight = Flight.new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trips_params)
    @trip.user = current_user
    if @trip.save
      redirect_to trip_path(@trip), notice: 'Trip was successfully created'
    else
      render "new"
    end
  end

  def show
    @trip = Trip.find(params[:id])
    # Initialize using parameters
    amadeus = Amadeus::Client.new(client_id: ENV['AMADEUS_CLIENT_ID'], client_secret: ENV['AMADEUS_CLIENT_SECRET'])
  #  https://test.api.amadeus.com/v1/duty-of-care/diseases/covid19-area-report?countryCode=US
    c = ISO3166::Country.find_country_by_name(@trip.destination)
    response = amadeus.get('/v1/duty-of-care/diseases/covid19-area-report', countryCode: c.alpha2)
    @risk_level = response.data["diseaseRiskLevel"]
    @test_required = response.data["areaAccessRestriction"]["diseaseTesting"]["isRequired"]
    @test_type = response.data["areaAccessRestriction"]["diseaseTesting"]["testType"]
    @mask_required = response.data["areaAccessRestriction"]["mask"]["isRequired"]

  end

  private
  def trips_params
    params.require(:trip).permit(:home, :destination)
  end
end
