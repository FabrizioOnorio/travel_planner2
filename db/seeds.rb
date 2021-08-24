# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(
  email: "bene@b.de",
  password: "123456"
)

Flight.create!(
  date: "2021-12-01",
  departure: "Germany",
  destination: "Sweden",
  facemask_flight: "Medical",
  facemask_destination: "Medical",
  test_required: "PCR",
  vaccination_requirment: "no"
)

Trip.create!(
  flight_id: 1,
  user_id: 1
)
