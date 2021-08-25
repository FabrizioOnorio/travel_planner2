class RemoveFlightFromTrip < ActiveRecord::Migration[6.0]
  def change
    remove_reference :trips, :flight, null: false, foreign_key: true
  end
end
