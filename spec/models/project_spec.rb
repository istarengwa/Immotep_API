require 'rails_helper'
require 'faker'

RSpec.describe Project, type: :model do
  it 'no create for no user' do
    Project.create(title: 'Rspec Test')
    expect(Project.count).to eq(0)
  end

  it 'create and persist two projects for one user' do
    User.create(email: Faker::Internet.email, password: "password")
    
    User.all.each do |user|
      user_id = user.id
      2.times do
        Project.create(
          title: Faker::Movies::StarWars.specie, 
          comment: Faker::Movies::StarWars.wookiee_sentence, 
          localization: Faker::Movies::StarWars.planet, 
          user_id: user_id
        )
      end
    end

    expect(Project.count).to eq(2)
  end

  context 'housing association' do 
    it 'add one hounsing in one project' do
      user = User.create(email: "rspec@rspec.test", password: "password")
      project = Project.create(title: "Test rspec", user_id: user.id)
      project.housings << Housing.new(ad_price: 5, project_id: project.id)
      project.save
      expect(Housing.count).to eq(1)
      expect(project.housings.count).to eq(1)
    end
  end

end