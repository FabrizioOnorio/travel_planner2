class FlightsController < ApplicationController
  def new
    @flight = Flight.new
  end

  def create
    @flight = Flight.new(flight_params)
    if @flight.save
      redirect_to @flight, notice: 'Flight was successfully created'
    else
      render :new
    end
    @me = current_user
  end

  private

  def flight_params
    params.require(:flight).permit(:date, :departure, :destination, :flight_number)
  end
end
