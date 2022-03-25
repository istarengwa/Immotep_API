require 'rails_helper'
require 'faker'

RSpec.describe Project, type: :model do
  it 'no create for no user' do
    Project.create(title: 'Rspec Test')
    expect(Project.count).to eq(0)
  end

  it 'create and persist two projects for one user' do
    user = User.create(email: "rspec@rspec.test", password: "password")
    
    2.times do
      Project.create(title: "Test rspec", user_id: user.id)
    end

    expect(Project.count).to eq(2)
  end

  context 'housing association' do 
    it 'add one hounsing in one project' do
      user = User.create(email: "rspec@rspec.test", password: "password")
      project = Project.create(title: "Test rspec", user_id: user.id)
      project.housings << Housing.new(ad_price: 5, localization: "test", property_category: "Studio", project_id: project.id)
      project.save
      expect(Housing.count).to eq(1)
      expect(project.housings.count).to eq(1)
    end
  end

end