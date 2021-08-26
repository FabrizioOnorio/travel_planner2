class Trip < ApplicationRecord
  belongs_to :user

  has_many :trip_flights
  has_many :flights, through: :trip_flights

end
