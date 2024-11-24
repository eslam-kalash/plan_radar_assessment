# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

# Create 200 users
users = []
200.times do
  users << User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    send_due_date_reminder: [true, false].sample,
    due_date_reminder_interval: rand(0..3), # assuming intervals in days
    due_date_reminder_time:  Time.now.change(hour: rand(0..23), min: rand(0..59), sec: 0) + 1.day,
    time_zone: "UTC"
  )
end

puts "Created #{User.count} users"

# Create 400 tickets
400.times do
  Ticket.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph,
    assigned_user_id: users.sample.id, # Randomly assign a user
    due_date: Faker::Date.between(from: DateTime.now.utc, to: DateTime.now.utc + 3.days),
    status_id: rand(1..2), # assuming 5 possible statuses
    progress: rand(0..3)
  )
end

puts "Created #{Ticket.count} tickets"
