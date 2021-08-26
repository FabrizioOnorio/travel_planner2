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
  end


  private


  def trips_params
    params.require(:trip).permit(:inbound_id, :outbound_id, :user_id, :flight_id)

  end
end
