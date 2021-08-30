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
  end

  private
  def trips_params
    params.require(:trip).permit(:home, :destination)
  end
end
