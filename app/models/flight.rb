class Flight < ApplicationRecord
  attr_accessor :return_date

  has_many :trips_as_inbound, class_name: "Trip", foreign_key: :inbound_id
  has_many :trips_as_outbound, class_name: "Trip", foreign_key: :outbound_id
end
