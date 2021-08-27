class Flight < ApplicationRecord
  has_many :trip_flights
  def to_label
    "#{departure} to #{destination}"
  end
end
