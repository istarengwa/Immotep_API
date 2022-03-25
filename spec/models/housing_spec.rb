require 'rails_helper'

RSpec.describe Housing, type: :model do

  describe 'Model Housing' do
    let!(:user) { create(:user) }
    let!(:project) { create(:project) }
    let!(:housing) { build(:housing) }
    let!(:housing1) { build(:housing, project_id: nil) }

    it 'no create for no user' do
      housing1.save
      expect(Housing.count).to eq(0)
    end

    it 'create housing for one project' do
      housing.save
      expect(Housing.count).to eq(1)
    end

    context "don't create if wrong params" do
      let!(:housing_invalid) { build(:housing, localization: nil) }
      let!(:housing_invalid1) { build(:housing, property_category: nil) }
      let!(:housing_invalid2) { build(:housing, ad_price: nil) }

      it "don't create housing without localization" do
        housing_invalid.save
        expect(Housing.count).to eq(0)
      end

      it "don't create housing without property_category" do
        housing_invalid1.save
        expect(Housing.count).to eq(0)
      end

      it "don't create housing without ad_price" do
        housing_invalid2.save
        expect(Housing.count).to eq(0)
      end
    end

    it 'should validate content length' do
      expect(housing1.valid?).to be false
    end
  end
end