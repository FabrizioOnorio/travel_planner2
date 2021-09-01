class AddFlightIdToFlights < ActiveRecord::Migration[6.0]
  def change
    add_column :flights, :api_flight_id, :integer
  end
end
