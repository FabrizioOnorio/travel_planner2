class TripsController < ApplicationController

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(flight_params)
    if @trip.save
      redirect_to @flight, notice: 'Flight was successfully created'
    else
      render :new
    end
    @me = current_user
  end

  def index
  end

  private

  def flight_params
    params.require(:flight).permit(:date, :departure, :destination, :flight_number)
  end


end
