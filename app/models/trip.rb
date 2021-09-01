class Trip < ApplicationRecord
  belongs_to :user

  has_many :trip_flights, dependent: :destroy
  has_many :flights, through: :trip_flights
  geocoded_by :destination
  after_validation :geocode
end
