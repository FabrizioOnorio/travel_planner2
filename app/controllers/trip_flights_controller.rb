class TripFlightsController < ApplicationController
  def new
    @trip = Trip.find(params[:trip_id])
    @trip_flight = TripFlight.new
  end

  def create
    @trip = Trip.find(params[:trip_id])
    create_outbound
    create_inbound
    redirect_to trip_flights_path(@trip)
  end

  private

  def create_outbound
    flight = Flight.new(trip_flight_params.dig(:departure_flight))
    flight.date = params[:trip_flight][:departure_flight][:departure_date]
    flight.save!
    trip_flight = TripFlight.new(trip: @trip, flight: flight, flight_type: "outbound")
    trip_flight.save
  end

  def create_inbound
    flight = Flight.new
    flight.date = params[:trip_flight][:departure_flight][:return_date]
    flight.departure = params[:trip_flight][:departure_flight][:destination]
    flight.destination = params[:trip_flight][:departure_flight][:departure]
    flight.save!
    trip_flight = TripFlight.new(trip: @trip, flight: flight, flight_type: "inbound")
    trip_flight.save
  end

  def trip_flight_params
    params.require(:trip_flight)
    .permit(
      departure_flight: [
        :departure,
        :destination
      ]
    )
  end
end
