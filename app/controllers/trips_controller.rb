class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def new
    @flight = Flight.new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(user: current_user)
    if @trip.save
      redirect_to new_trip_trip_flight_path(@trip), notice: 'Trip was successfully created'
    else
      render "/"
    end
  end

  def show
    @trip = Trip.find(params[:id])
    # Initialize using parameters
    amadeus = Amadeus::Client.new(client_id: ENV['AMADEUS_CLIENT_ID'], client_secret: ENV['AMADEUS_CLIENT_SECRET'])
  #  https://test.api.amadeus.com/v1/duty-of-care/diseases/covid19-area-report?countryCode=US
    response = amadeus.get('/v1/duty-of-care/diseases/covid19-area-report', countryCode: 'IT')
    @risk_level = response.data["diseaseRiskLevel"]
    @test_required = response.data["areaAccessRestriction"]["diseaseTesting"]["isRequired"]
    @test_type = response.data["areaAccessRestriction"]["diseaseTesting"]["testType"]
    @mask_required = response.data["areaAccessRestriction"]["mask"]["isRequired"]
 
  end

  private
  def trips_params
    params.require(:trip).permit(:inbound_id, :outbound_id, :user_id, :flight_id)
  end
end
