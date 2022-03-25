require 'rails_helper'
require 'faker'

RSpec.describe Housing, type: :model do
  
  it 'no create for no user' do
    Housing.create(ad_price: 25, property_category: "Studio", localization: "test")
    expect(Project.count).to eq(0)
  end

  it 'create two housing for one project' do
    
    user = User.create(email: "rspec@rspec.test", password: "password")    
    project = Project.create(title: "Test rspec", user_id: user.id)

    2.times do
      Housing.create(ad_price: 254512, localization: "test", property_category: "Studio", project_id: project.id)
    end

    expect(Housing.count).to eq(2)
  end 

  context 'validation' do
    it 'should validate content length' do
      housing = Housing.new(comment: "!blabla@")
      expect(housing.valid?).to be false
    end
  end
end