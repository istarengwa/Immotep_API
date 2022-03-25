require 'rails_helper'
require 'faker'

RSpec.describe Project, type: :model do
  
  context 'modelUser' do 
    describe "bad params" do
      let!(:user_invalid) { build(:user, email: nil) }
      let!(:user_invalid1) { build(:user, password: nil) }


      it 'can\'t create a user cause of wrong params' do
        user_invalid.save
        user_invalid1.save
        expect(User.count).to eq(0)
      end
    end

    describe 'good params' do 
      let!(:user) { create(:user) }
      it 'can create a user with good params' do
        user.save
        expect(User.count).to eq(1)
      end
    end
  end

end