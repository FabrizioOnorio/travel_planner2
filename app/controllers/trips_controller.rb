class TripsController < ApplicationController
  def index
    @trips = current_user.trips
  end

  def new
    @flight = Flight.new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trips_params)
    @trip.user = current_user

    @trip.home_json = api_call_for_country(@trip.home)
    @trip.destination_json = api_call_for_country(@trip.destination)

    if @trip.save
      redirect_to new_trip_trip_flight_path(@trip), notice: 'Trip was successfully created'
    else
      render "new"
    end

  end

  def show
    @trip = Trip.find(params[:id])
    # Initialize using parameters
    unless @trip.home_json.nil?
      home_data = JSON.parse(@trip.home_json)
      @risk_level_home = home_data["data"]["diseaseRiskLevel"]
      @test_required_home = home_data["data"]["areaAccessRestriction"]["diseaseTesting"]["isRequired"]
      @test_type_home = home_data["data"]["areaAccessRestriction"]["diseaseTesting"]["testType"]
      @mask_required_home = home_data["data"]["areaAccessRestriction"]["mask"]["isRequired"]
      @infection_link_home = home_data["data"]["diseaseInfection"]["infectionMapLink"]
      @source_link_home = home_data["data"]["dataSources"]["governmentSiteLink"]
      @when_to_test_home = home_data["data"]["areaAccessRestriction"]["diseaseTesting"]["when"]
      @test_more_infos_home = home_data["data"]["areaAccessRestriction"]["diseaseTesting"]["text"]
      @quarantine_more_infos_home = home_data["data"]["areaAccessRestriction"]["quarantineModality"]["text"]
      @exit_requirments_home = home_data["data"]["areaAccessRestriction"]["exit"]["text"]
      @exit_rules_link_home = home_data["data"]["areaAccessRestriction"]["exit"]["rulesLink"]
      @array_of_banned_countries_home = home_data["data"]["areaAccessRestriction"]["entry"]["bannedArea"]
    end
    unless @trip.destination_json.nil?
      destination_data = JSON.parse(@trip.destination_json)
      @risk_level_destination = destination_data["data"]["diseaseRiskLevel"]
      @test_required_destination = destination_data["data"]["areaAccessRestriction"]["diseaseTesting"]["isRequired"]
      @test_type_destination = destination_data["data"]["areaAccessRestriction"]["diseaseTesting"]["testType"]
      @mask_required_destination = destination_data["data"]["areaAccessRestriction"]["mask"]["isRequired"]
      @infection_link_destination = destination_data["data"]["diseaseInfection"]["infectionMapLink"]
      @source_link_destination = destination_data["data"]["dataSources"]["governmentSiteLink"]
      @when_to_test_destination = destination_data["data"]["areaAccessRestriction"]["diseaseTesting"]["when"]
      @test_more_infos_destination = destination_data["data"]["areaAccessRestriction"]["diseaseTesting"]["text"]
      @quarantine_more_infos_destination = destination_data["data"]["areaAccessRestriction"]["quarantineModality"]["text"]
      @exit_requirments_destination = destination_data["data"]["areaAccessRestriction"]["exit"]["text"]
      @exit_rules_link_destination = destination_data["data"]["areaAccessRestriction"]["exit"]["rulesLink"]
      @array_of_banned_countries_destination = destination_data["data"]["areaAccessRestriction"]["entry"]["bannedArea"]
    end
  end

  private

  def trips_params
    params.require(:trip).permit(:home, :destination)
  end

  def api_call_for_country(country)
    amadeus = Amadeus::Client.new(client_id: ENV['AMADEUS_CLIENT_ID'], client_secret: ENV['AMADEUS_CLIENT_SECRET'])
    country_iso = ISO3166::Country.find_country_by_name(country)
    response = amadeus.get('/v1/duty-of-care/diseases/covid19-area-report', countryCode: country_iso.alpha2)
    response.to_json
  end
end
