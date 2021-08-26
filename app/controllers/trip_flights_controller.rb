class TripFlightsController < ApplicationController
  def new
    @trip = Trip.find(params[:trip_id])
    @trip_flight = TripFlight.new
  end

  def create
    @trip = Trip.find(params[:trip_id])
    @flights = Flight.find(params[:trip_flight][:flight])
    @flights.each do |flight|
      trip_flight = TripFlight.new
      trip_flight.trip = @trip
      trip_flight.flight = flight
      trip_flight.save
    end
    redirect_to trip_path(@trip)
  end
end
