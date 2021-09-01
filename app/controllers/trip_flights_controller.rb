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
    flight = Flight.create(trip_flight_params.dig(:departure_flight))
    trip_flight = TripFlight.new(trip: @trip, flight: flight, flight_type: "outbound")
    trip_flight.save
  end

  def create_inbound
    flight = Flight.create(trip_flight_params.dig(:return_flight))
    trip_flight = TripFlight.new(trip: @trip, flight: flight, flight_type: "inbound")
    trip_flight.save
  end

  def trip_flight_params
    params.require(:trip_flight)
    .permit(
      return_flight: [
        :departure,
        :destination,
        :date
      ],
      departure_flight: [
        :departure,
        :destination,
        :date
      ]
    )
  end
end
