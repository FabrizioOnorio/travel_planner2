class AddOutboundInboundToTrip < ActiveRecord::Migration[6.0]
  def change
    add_reference :trips, :inbound, null: false, foreign_key: { to_table: :flights }
    add_reference :trips, :outbound, null: false, foreign_key: { to_table: :flights }
  end
end
