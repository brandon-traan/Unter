# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(first:                   "Root",
             lastname:               "Admin",
             email:   "root_admin@email.com",
             password:              "123456",
             password_confirmation: "123456",
             role: "Admin")
             
User.create!(first:                   "Root",
             lastname:               "SuperAdmin",
             email: "root_superadmin@email.com",
             password:              "123456",
             password_confirmation: "123456",
             role: "SuperAdmin")
             
User.create!(name:  "Example Customer",
             email: "example_customer@email.com",
             phone:             "1234567890",
             licenseN:           "123456789",
             password:              "123456",
             password_confirmation: "123456",
             role: "Customer")

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
50.times do |cnt|
    make = Faker::Vehicle.manufacture
    model = "model#{cnt%8}"
    price = Faker::Number.between(80.00, 300.00)
    size = "#{Car.styles.key(cnt%3)}"
    location = Faker::Address.street_address
    status = "Available"
    Car.create!(
        make: make,
        model: model,
        price: price,
        size: size,
        location: location,
        status: status)
end