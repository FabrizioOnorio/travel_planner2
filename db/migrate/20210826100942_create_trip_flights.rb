class CreateTripFlights < ActiveRecord::Migration[6.0]
  def change
    create_table :trip_flights do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :flight, null: false, foreign_key: true
      t.string :flight_type

      t.timestamps
    end
  end
end
