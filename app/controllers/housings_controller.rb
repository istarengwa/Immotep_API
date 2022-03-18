class HousingsController < ApplicationController
  include ActionController::Helpers
  include HousingsHelper

  before_action :set_housing, only: %i[ show update destroy ]
  before_action :authenticate_user!

  # GET /housings
  def index
    unauthorized_show_all && return if no_owner_user

    @housings = Housing.where(project_id: project_find)

    render json: @housings
  end

  # GET /housings/1
  def show
    unauthorized_show && return if no_owner_user

    render json: @housing
  end

  # POST /housings
  def create
    unauthorized_create && return if no_owner_user
    
    @housing = Housing.new(all_params)

    if @housing.save
      render json: @housing, status: :created, location: @housing
    else
      render json: @housing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /housings/1
  def update
    unauthorized_udpate && return if no_owner_user

    if @housing.update(housing_params)
      render json: @housing
    else
      render json: @housing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /housings/1
  def destroy
    unauthorized_destroy && return if no_owner_user

    @housing.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_housing
      @housing = Housing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def housing_params
      params.require(:housing).permit(:ad_price, :property_category, :localization, :area, :ad_url, :comment, :offer_price, :repairs_price, :annual_rent, :notary_fees, :agency_fees, :pno_insurance, :property_tax, :rental_management, :rental_unpayment_insurance, :building_co_tax, :maintenance_percentage, :ad_profitability, :offer_profitability, :new_property, :rental_vacancy, :project)
    end
end
