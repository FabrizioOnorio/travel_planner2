class AddHomeDestinationHomeJsonDestinationJsonToTrips < ActiveRecord::Migration[6.0]
  def change
    add_column :trips, :home, :string
    add_column :trips, :destination, :string
    add_column :trips, :home_json, :json
    add_column :trips, :destination_json, :json
  end
end
