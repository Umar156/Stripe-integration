# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Creating Workshops"
Workshop.create([{ name: "Ticket booking system",
                   description: "Dummy Data of ticket booking system.",
                   start_date: Date.today,
                   end_date: Date.today + 30,
                   start_time: "10:00 am",
                   end_time: "5:00 pm",
                   total_seats: 100,
                   remaining_seats: 0,
                   registration_fee: 2000
                 },
                 { name: "Ticket booking system 1",
                   description: "Dummy Data of ticket booking system.",
                   start_date: Date.today,
                   end_date: Date.today + 30,
                   start_time: "10:00 am",
                   end_time: "5:00 pm",
                   total_seats: 100,
                   remaining_seats: 0,
                   registration_fee: 2000
                 },
                 { name: "Ticket booking system 2",
                   description: "Dummy Data of ticket booking system.",
                   start_date: Date.today,
                   end_date: Date.today + 30,
                   start_time: "10:00 am",
                   end_time: "5:00 pm",
                   total_seats: 100,
                   remaining_seats: 0,
                   registration_fee: 2000
                 }])
puts "Created Workshops"