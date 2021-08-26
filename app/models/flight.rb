class Flight < ApplicationRecord
  attr_accessor :return_date

  # belongs_to :inbound, class_name: "Trip"
  # belongs_to :outbound, class_name: "Trip"
end
