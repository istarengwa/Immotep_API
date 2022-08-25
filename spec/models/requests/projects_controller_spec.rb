require 'rails_helper'


=begin

#### SCHEDULE 

# >> INDEX current_user if @projects include curent_user's project,  render response status (200), 
# >> Show  project == curent_user if =! raise error, render,
# >> Create project --> To check that the project count added 1 project, render response status (200) if project.save else raise error
# >> Update --> project == curent_user if =! raise error, Project.update effective, raise_error if status: :unprocessable_entity
# >> Destroy --> project == curent_user if =! raise error, To check that the project count remove 1 project 
# >>

=end

RSpec.describe ProjectsController, type: :request do
  context 'GET / Index' do
    let(:user) { create(:user) }
    let(:project) { build(:project, user_id: current_user.id)} 
    
    
    it 'only render the current_user projects' do
      sign_in(create(:user))
      get :index
      project
      expect(current_user.projects).to eq(Project.where(user_id: user.id) )
    end
    it 'render ' do
      get :index
      expect(response).to have_http_status(200)
    end
  end 
end

=begin
  describe '#show' do
    context 'when a non-user/no_owner_user try to go on url show' do
      it 'respond with unauthorized_show'
    end

    context 'when an authorized user render the show' do
      it "send project's json to the view"
    end
  end 


  context '#create' do 
    describe "check that one project linked to an user been created" do
        it 'create a project' do
          get :create
          expect(response).to have_http_status(200)
        end
    end
  end


  context '#update' do 
    describe "when a no_owner_user proceed for an update" do
        it 'respond with unauthorized_update' do
          get :update
          expect(response).to have_http_status(200)
        end
    end
  end

  context '#destroy' do 
    describe "when a no_owner_user proceed for a project destruction" do
        it 'respond with unauthorized_destroy'

    end
  end 

=end
