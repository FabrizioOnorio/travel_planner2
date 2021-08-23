class CreateFlights < ActiveRecord::Migration[6.0]
  def change
    create_table :flights do |t|
      t.date :date
      t.string :departure
      t.string :destination
      t.string :flight_number
      t.string :facemask_flight
      t.string :facemask_destination
      t.string :test_required
      t.string :vaccination_requirment

      t.timestamps
    end
  end
end
