class HousingsController < ApplicationController
  before_action :set_housing, only: %i[ show update destroy ]
  before_action :authenticate_user!
  before_action :owner_user, only: %i[ show update destroy ]

  # GET /housings
  def index
    @housings = Housing.all

    render json: @housings
  end

  # GET /housings/1
  def show
    render json: @housing
  end

  # POST /housings
  def create
    @housing = Housing.new(
      ad_price: housing_params[:ad_price],
      property_category: housing_params[:property_category],
      localization: housing_params[:localization],
      offer_price: housing_params[:ad_price],
      notary_fees: ((housing_params[:ad_price]).to_i * 0.08).to_i,
      agency_fees: ((housing_params[:ad_price]).to_i * 0.08).to_i,
      maintenance_percentage: 2,
      rental_vacancy: 6,
      project_id: params[:project_id]
    )

    if @housing.save
      render json: @housing, status: :created, location: @housing
    else
      render json: @housing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /housings/1
  def update
    if @housing.update(housing_params)
      render json: @housing
    else
      render json: @housing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /housings/1
  def destroy
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

    #Vérifie que l'user qui consulte est celui qui a créé le projet
    def owner_user
      if @housing.project.user == current_user
        return true
      end
    end
end
