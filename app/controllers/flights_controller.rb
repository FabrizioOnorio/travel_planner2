class FlightsController < ApplicationController
  AMADEUS = Amadeus::Client.new(client_id: ENV['AMADEUS_CLIENT_ID'], client_secret: ENV['AMADEUS_CLIENT_SECRET'])

  def index
    @trip = Trip.find(params[:trip_id])
    @outbound = @trip.trip_flights.find_by(flight_type: "outbound").flight
    @inbound = @trip.trip_flights.find_by(flight_type: "inbound").flight


    # only api call if flight number not present/ flight not yet booked
    @outbound_flights = flights_data(@outbound)
    @inbound_flights = flights_data(@inbound)
  end

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

  def update
    @flight = Flight.find(params[:id])
    @flight.update(flight_params)
    @trip = Trip.find(params[:trip_id])
    redirect_to trip_flights_path(@trip)
  end

  def show

    @trip = Trip.find(params[:id])


    # Initialize using parameters

  #  https://test.api.amadeus.com/v1/duty-of-care/diseases/covid19-area-report?countryCode=US
    c = ISO3166::Country.find_country_by_name(@trip.destination)
    response = AMADEUS.get('/v1/duty-of-care/diseases/covid19-area-report', countryCode: c.alpha2)
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
    params.require(:flight).permit(:date, :departure, :destination, :flight_number, :api_flight_id)
  end


  def return_flight_params
    params.require(:flight).permit(:return_date, :departure, :destination, :flight_number)
  end

  def flights_data(flight)
    @results = JSON.parse(AMADEUS.shopping.flight_offers_search.get(originLocationCode: flight.departure, destinationLocationCode: flight.destination, departureDate: flight.date.strftime("%Y-%m-%d"), adults: 1, max: 20).body)

    @results["data"].map do |flight_data|

      {
        id: flight_data["id"],
        carrier: set_carrier(flight_data),
        departure: set_airport_iata(flight_data, "departure"),
        departure_full: Airports.find_by_iata_code(set_airport_iata(flight_data, "departure")).name,
        departure_time: set_flight_hour(flight_data, "departure"),
        arrival: set_airport_iata(flight_data, "arrival"),
        arrival_full: Airports.find_by_iata_code(set_airport_iata(flight_data, "arrival")).name,
        arrival_time: set_flight_hour(flight_data, "arrival"),
        flight_number: set_flight_number(flight_data),
        price: set_price(flight_data)
      }
    end
  end

  def set_price(flight_data)
    flight_data["price"]["total"]
  end

  def set_flight_number(flight_data)
    flight_data["itineraries"][0]["segments"][0]["carrierCode"] + flight_data["itineraries"][0]["segments"][0]["number"]
  end

  def set_flight_hour(flight_data, airport_type)
    DateTime.parse(flight_data["itineraries"][0]["segments"][0][airport_type]["at"]).strftime("%l:%M %p")
  end

  def set_carrier(flight_data)
    carriers = @results["dictionaries"]["carriers"]
    carriers[flight_data["itineraries"][0]["segments"][0]["carrierCode"]]
  end

  def set_airport_iata(flight_data, airport_type)
    flight_data["itineraries"][0]["segments"][0][airport_type]["iataCode"]
  end
end
