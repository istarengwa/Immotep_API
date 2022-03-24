require 'rails_helper'
require 'faker'

RSpec.describe Housing, type: :model do
  
  it 'no create for no user' do
    Housing.create(ad_price: Faker::Number.number(digits: 2))
    expect(Project.count).to eq(0)
  end

  it 'create two housing for one project' do
    User.create(email: Faker::Internet.email, password: "password")
    
    User.all.each do |user|
      user_id = user.id
      1.times do
        Project.create(
          title: Faker::Movies::StarWars.specie,
          user_id: user_id
        )
      end
    end

    Project.all.each do |project|
      project_id = project.id
      2.times do
        Housing.create(
          ad_price: Faker::Number.number(digits: 2),
          project_id: project_id
        )
      end
    end

    expect(Housing.count).to eq(2)
  end 
end