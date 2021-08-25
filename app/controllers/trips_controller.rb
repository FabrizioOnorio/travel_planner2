class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def new
    @flight = Flight.new
    @trip = Trip.new
  end

  def create
    @flight = Flight.new(flight_params)
    @trip = Trip.new(trips_params)
    @trip.user = current_user
    if @trip.save
      redirect_to @flight, notice: 'Flight was successfully created'
    else
      render :new
    end
  end

  private

  def trips_params
    params.require(:trip).permit(:inbound_id, :outbound_id, :user_id, :flight_id)
  end
end
