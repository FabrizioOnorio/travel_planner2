require "pry-byebug"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# step_one: destroy all seeds

puts "Destroying seeds"
TripFlight.destroy_all
Trip.destroy_all
Flight.destroy_all
User.destroy_all
puts "Seeds destroyed ✅"

puts "Create users"
# user_1
user_1 = User.create(
  email: "luke@luke.com",
  password: "123456",
  name: "Luke Wikstan",
  phonenumber: "473923923",
  fullvaccinated: "fully vaccinated"
)
# user_2
user_2 = User.create(
  email: "mike@mike.com",
  password: "123456",
  name: "Mike Lu",
  phonenumber: "473923984",
  fullvaccinated: "half vaccinated"
)
# user_3
user_3 = User.create(
  email: "matt@matt.com",
  password: "123456",
  name: "Matt Bill",
  phonenumber: "473923983",
  fullvaccinated: "not vaccinated"
)
# user_4
user_4 = User.create(
  email: "linn@linn.com",
  password: "123456",
  name: "Linn Moi",
  phonenumber: "473923567",
  fullvaccinated: "fully vaccinated"
)
puts "done with users ✅"
puts "create flights"
# flight_1
flight_1 = Flight.create!(
  date: DateTime.new(2009, 9, 19),
  departure: "Italy",
  destination: "Spain",
  flight_number: "DY445",
  facemask_flight: "N95",
  facemask_destination: "No facemask required",
  test_required: "PCR test 48 hours",
  vaccination_requirment: "Fully Vaccinated"
)
# flight_2
puts "test"
flight_2 = Flight.create!(
  date: DateTime.new(2009, 9, 20),
  departure: "Spain",
  destination: "Italy",
  flight_number: "DY450",
  facemask_flight: "N95",
  facemask_destination: "No facemask required",
  test_required: "PCR test 72 hours",
  vaccination_requirment: "Fully Vaccinated"
)
# flight_3
flight_3 = Flight.create!(
  date: DateTime.new(2009, 9, 15),
  departure: "Germany",
  destination: "France",
  flight_number: "LH225",
  facemask_flight: "Surgical Mask",
  facemask_destination: "facemask required",
  test_required: "PCR test 48 hours",
  vaccination_requirment: "Half Vaccinated"
)
# flight_4
flight_4 = Flight.create!(
  date: DateTime.new(2009, 9, 25),
  departure: "France",
  destination: "Germany",
  flight_number: "LH403",
  facemask_flight: "N95",
  facemask_destination: "No facemask required",
  test_required: "PCR test 72 hours",
  vaccination_requirment: "Fully Vaccinated"
)
# flight_5
flight_5 = Flight.create!(
  date: DateTime.new(2009, 9, 18),
  departure: "Norway",
  destination: "Belgium",
  flight_number: "TD444",
  facemask_flight: "Surgical Mark",
  facemask_destination: "Facemask required",
  test_required: "PCR test 48 hours",
  vaccination_requirment: "Fully Vaccinated"
)
# flight_6
flight_6 = Flight.create!(
  date: DateTime.new(2009, 9, 30),
  departure: "Belgium",
  destination: "Norway",
  flight_number: "TD607",
  facemask_flight: "Surgical Mask",
  facemask_destination: "No facemask required",
  test_required: "PCR test 48 hours",
  vaccination_requirment: "Fully Vaccinated"
)
# flight_7
flight_7 = Flight.create!(
  date: DateTime.new(2009, 9, 19),
  departure: "United Kingdom",
  destination: "Portugal",
  flight_number: "DY123",
  facemask_flight: "N95",
  facemask_destination: "No facemask required",
  test_required: "PCR test 24 hours",
  vaccination_requirment: "Partly Vaccinated"
)
# flight_8
flight_8 = Flight.create!(
  date: DateTime.new(2009, 9, 19),
  departure: "Portugal",
  destination: "United Kingdom",
  flight_number: "DY321",
  facemask_flight: "N95",
  facemask_destination: "No facemask required",
  test_required: "PCR test 72 hours",
  vaccination_requirment: "Fully Vaccinated"
)
puts "done withg flights ✅"
puts "create trips"
# trip_1
trip_1 = Trip.create(
  user: user_1
)
TripFlight.create(
  trip: trip_1, flight: flight_1, flight_type: "outbound"
)
TripFlight.create(

  trip: trip_1, flight: flight_2, flight_type: "inbound"

)
# trip_2
trip_2 = Trip.create(
  user: user_2
)
TripFlight.create(
  trip: trip_2, flight: flight_3, flight_type: "outbound"
)
TripFlight.create(
  trip: trip_2, flight: flight_4, flight_type: "inbound"
)
# trip_3
trip_3 = Trip.create(
  user: user_3
)
TripFlight.create(
  trip: trip_3, flight: flight_5, flight_type: "outbound"
)
TripFlight.create(
  trip: trip_3, flight: flight_6, flight_type: "inbound"
)
# trip_4
trip_4 = Trip.create(
  user: user_4
)
TripFlight.create(
  trip: trip_4, flight: flight_7, flight_type: "outbound"
)
TripFlight.create(
  trip: trip_4, flight: flight_8, flight_type: "inbound"
)
puts "done creating trips ✅"
puts "done with the seeds ✅✅✅"
