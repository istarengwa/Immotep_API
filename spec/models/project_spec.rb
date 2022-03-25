require 'rails_helper'
require 'faker'

RSpec.describe Project, type: :model do

  let!(:user) { create(:user) }
  let!(:project_invalid) { build(:project, user_id: nil) }
  let!(:projects) { create_list(:project, 2)}

  it 'no create for no user' do
    project_invalid.save
    expect(Project.count).to eq(2)
  end

  it 'creates and keeps two projects for one user' do
    expect(Project.count).to eq(2)
  end

  

  context 'housing association' do 

    let!(:housing) {create(:housing, project_id: projects.first.id)}

    it 'add one housing in one project' do
      expect(Housing.count).to eq(1)
      expect(projects.first.housings.count).to eq(1)
    end
  end

end