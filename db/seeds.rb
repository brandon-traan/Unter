# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(firstname:                   "Root",
             lastname:               "Admin",
             email:   "root_admin@email.com",
             password:              "12345678",
             password_confirmation: "12345678",
             role: "Admin")

User.create!(firstname:                   "Root",
             lastname:               "SuperAdmin",
             email: "root_superadmin@email.com",
             password:              "12345678",
             password_confirmation: "12345678",
             role: "SuperAdmin")

User.create!(firstname:  "Example Customer",
             lastname:  "Example Customer",
             email: "example_customer@email.com",
             phone:             "1234567890",
             licenseN:           "123456789",
             password:              "12345678",
             password_confirmation: "12345678",
             role: "Customer")

Car.create(
  make: "Toyota",
  model: "Camery",
  year: 2009,
  price: 90,
  size: "small",
  location: {lat: -37.8133664, lng: 144.9638285},
  status: "Available"
)



99.times do |n|
  firstname  = Faker::Name.first_name
  lastname  = Faker::Name.last_name
  email = "example-#{n+1}@rmit.org"
  phone =  Faker::Number.number(10)
  licenseN = Faker::Number.number(9)
  password = "password"
  role = "Customer"
  User.create!(firstname:  firstname,
               lastname: lastname,
               email: email,
               phone: phone,
               licenseN: licenseN,
               password:              password,
               password_confirmation: password,
               role: role)
end

# Generate Car samples:
# 50.times do |cnt|
#     make = Faker::Vehicle.manufacture
#     model = "model#{cnt%8}"
#     year = Faker::Number.between(2005.00, 2018.00)
#     price = Faker::Number.between(80.00, 300.00)
#     size = "#{Car.sizes.key(cnt%3)}"
#     location = Faker::Address.street_address
#     status = "Available"
#     Car.create!(
#         make: make,
#         model: model,
#         year: year,
#         price: price,
#         size: size,
#         location: location,
#         status: status)
# end
