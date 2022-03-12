require "test_helper"

class HousingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @housing = housings(:one)
  end

  test "should get index" do
    get housings_url, as: :json
    assert_response :success
  end

  test "should create housing" do
    assert_difference("Housing.count") do
      post housings_url, params: { housing: { ad_price: @housing.ad_price, ad_profitability: @housing.ad_profitability, ad_url: @housing.ad_url, agency_fees: @housing.agency_fees, annual_rent: @housing.annual_rent, area: @housing.area, building_co_tax: @housing.building_co_tax, comment: @housing.comment, localization: @housing.localization, maintenance_percentage: @housing.maintenance_percentage, new_property: @housing.new_property, notary_fees: @housing.notary_fees, offer_price: @housing.offer_price, offer_profitability: @housing.offer_profitability, pno_insurance: @housing.pno_insurance, property_category: @housing.property_category, property_tax: @housing.property_tax, rental_management: @housing.rental_management, rental_unpayment_insurance: @housing.rental_unpayment_insurance, rental_vacancy: @housing.rental_vacancy, repairs_price: @housing.repairs_price } }, as: :json
    end

    assert_response :created
  end

  test "should show housing" do
    get housing_url(@housing), as: :json
    assert_response :success
  end

  test "should update housing" do
    patch housing_url(@housing), params: { housing: { ad_price: @housing.ad_price, ad_profitability: @housing.ad_profitability, ad_url: @housing.ad_url, agency_fees: @housing.agency_fees, annual_rent: @housing.annual_rent, area: @housing.area, building_co_tax: @housing.building_co_tax, comment: @housing.comment, localization: @housing.localization, maintenance_percentage: @housing.maintenance_percentage, new_property: @housing.new_property, notary_fees: @housing.notary_fees, offer_price: @housing.offer_price, offer_profitability: @housing.offer_profitability, pno_insurance: @housing.pno_insurance, property_category: @housing.property_category, property_tax: @housing.property_tax, rental_management: @housing.rental_management, rental_unpayment_insurance: @housing.rental_unpayment_insurance, rental_vacancy: @housing.rental_vacancy, repairs_price: @housing.repairs_price } }, as: :json
    assert_response :success
  end

  test "should destroy housing" do
    assert_difference("Housing.count", -1) do
      delete housing_url(@housing), as: :json
    end

    assert_response :no_content
  end
end
