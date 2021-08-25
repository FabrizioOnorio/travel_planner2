class FlightsController < ApplicationController

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

  def show
    @flight = Flight.find(params[:id])
  end

  private

  def flight_params
    params.require(:flight).permit(:date, :departure, :destination, :flight_number)
  end


  def return_flight_params
    params.require(:flight).permit(:return_date, :departure, :destination, :flight_number)
  end

end
