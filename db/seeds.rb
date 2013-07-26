# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Booking.destroy_all
Client.destroy_all
Page.destroy_all


User.create(email: 'test', password: 'test')
5.times do |i|
  User.create(email: Faker::Internet.email, password: 'i')
end

clients = Client.create([
	{name: "McLame"},
	{name: "Hawt Dawgs"},
  {name: "Chakko"},
  {name: "Stylo Pylo"},
  {name: "Blackboard Learns"},
  {name: "Sikkai"},
  {name: "Onigri R Us"},
  {name: "Ali Aamiring"},
  {name: "Orange Phones"},
  {name: "Beats By B"},
  {name: "Burrito Galz"},
  {name: "Boys 2 Code"},
  {name: "RayBands"},
  {name: "Benders Great"},
  {name: "Mehhiko"},
  {name: "IceWater"},
  {name: "Bitfaker"},
  {name: "MakerCubed"},
  {name: "Gitrub"},
  {name: "JumboSizeMe"}
])

5.times do |i|
  Page.create(slug: Faker::Internet.domain_name, 
    name: Faker::Internet.domain_word)
end