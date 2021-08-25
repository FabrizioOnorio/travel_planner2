class AddOutboundInboundToTrip < ActiveRecord::Migration[6.0]
  def change
      change_table :trips do |t|
        t.references :inbound, foreign_key: { to_table: :flights }
        t.references :outbound, foreign_key: { to_table: :flights }
      end
  end
end
