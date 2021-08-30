class FlightsController < ApplicationController

  def new
    @flight = Flight.new
  end

  def create
    @flight = Flight.new(flight_params)
    @return_flight = Flight.new(return_flight_params)
    @return_flight.date = Date.new(params["flight"]["return_date(1i)"].to_i, params["flight"]["return_date(2i)"].to_i, params["flight"]["return_date(3i)"].to_i)
    @return_flight.departure = @flight.destination
    @return_flight.destination = @flight.departure
    if @flight.save
      redirect_to @flight, notice: 'Flight was successfully created'
    else
      render :new
    end
  end

  def show
    @flight = Flight.find(params[:id])
    # Initialize using parameters
    amadeus = Amadeus::Client.new(client_id: ENV['AMADEUS_CLIENT_ID'], client_secret: ENV['AMADEUS_CLIENT_SECRET'])
  #  https://test.api.amadeus.com/v1/duty-of-care/diseases/covid19-area-report?countryCode=US
    response = amadeus.get('/v1/duty-of-care/diseases/covid19-area-report', countryCode: 'IT')
    @risk_level = response.data["diseaseRiskLevel"]
    @infection_link = response.data["diseaseInfection"]["infectionMapLink"]
    @source_link = response.data["dataSources"]["governmentSiteLink"]
    @test_required = response.data["areaAccessRestriction"]["diseaseTesting"]["isRequired"]
    @test_type = response.data["areaAccessRestriction"]["diseaseTesting"]["testType"]
    @when_to_test = response.data["areaAccessRestriction"]["diseaseTesting"]["when"]
    @test_more_infos = response.data["areaAccessRestriction"]["diseaseTesting"]["text"]
    @quarantine_more_infos = response.data["areaAccessRestriction"]["quarantineModality"]["text"]
    @mask_required = response.data["areaAccessRestriction"]["mask"]["isRequired"]
    @exit_requirments = response.data["areaAccessRestriction"]["exit"]["text"]
    @exit_rules_link = response.data["areaAccessRestriction"]["exit"]["rulesLink"]
    @array_of_banned_countries = response.data["areaAccessRestriction"]["entry"]["bannedArea"]

  end

  private

  def flight_params
    params.require(:flight).permit(:date, :departure, :destination, :flight_number)
  end


  def return_flight_params
    params.require(:flight).permit(:return_date, :departure, :destination, :flight_number)
  end

end
