# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
User.destroy_all
Project.destroy_all
Housing.destroy_all

User.create(email: "test@test.fr", password: "password")

3.times do
  User.create(email: Faker::Internet.email, password: "password")
  puts("User is created")
end

User.all.each do |user|
  user_id = user.id
  2.times do
    Project.create(title: Faker::Movies::StarWars.specie, comment: Faker::Movies::StarWars.wookiee_sentence, localization: Faker::Movies::StarWars.planet, user_id: user_id)
  puts("Project is created")

  end
end

Project.all.each do |project|
  project_id = project.id
  2.times do
  Housing.create(ad_price: Faker::Number.number(digits: 6), property_category: Faker::Movies::StarWars.droid, project_id: project_id)   
  puts("Housing is created")

  end
end