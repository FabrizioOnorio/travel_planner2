class Flight < ApplicationRecord
  belongs_to :trip
  validates :date, presence: true
  validates :destination, presence: true
end
