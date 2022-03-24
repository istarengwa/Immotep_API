module HousingsHelper
  def unauthorized_create
    render json: {
      error: {
        title: "Vous n'êtes pas authorisé à créer un housing sur un projet qui n'est pas à vous"
      }
    }
  end

  def unauthorized_update
    render json: {
      error: {
        title: "Vous n'êtes pas authorisé à modifier un housing qui n'est pas à vous"
      }
    }
  end

  def unauthorized_destroy
    render json: {
      error: {
        title: "Vous n'êtes pas authorisé à supprimer un housing qui n'est pas à vous"
      }
    }
  end

  def unauthorized_show_all
    render json: {
      error: {
        title: "Vous n'êtes pas authorisé à voir les housings d'un projet qui n'est pas à vous"
      }
    }
  end

  def unauthorized_show
    render json: {
      error: {
        title: "Vous n'êtes pas authorisé à voir un housing qui n'est pas à vous"
      }
    }
  end

  def project_find
    Project.find(params[:project_id])
  end

  def no_owner_user
    if current_user.id != project_find.user_id
      return true
    end
  end

  def all_params 
    housing_params.merge(
      area: 0,
      offer_price: housing_params[:ad_price],
      repairs_price: 0,
      annual_rent: 0,
      notary_fees: ((housing_params[:ad_price]).to_i * 0.08).to_i,
      agency_fees: ((housing_params[:ad_price]).to_i * 0.08).to_i,
      pno_insurance: 0,
      property_tax: 0,
      rental_unpayment_insurance: 0,
      building_co_tax: 0,
      maintenance_percentage: 2,
      rental_vacancy: 6,
      project_id: params[:project_id]
    )
  end

  def all_params_update
    housing_params.merge(
      ad_profitability: calculate_profitability(Housing.find(params[:id]).ad_price),
      offer_profitability: calculate_profitability(Housing.find(params[:id]).offer_price),  
      notary_fees: ((Housing.find(params[:id]).offer_price).to_i * 0.08).to_i,
      agency_fees: ((Housing.find(params[:id]).offer_price).to_i * 0.08).to_i
    )
  end
        
  def calculate_profitability(price)
    housing = Housing.find(params[:id])

    price = price || 0
    property_tax = housing.property_tax || 0
    ad_price = housing.ad_price || 0
    maintenance_percentage = housing.maintenance_percentage || 0
    building_co_tax = housing.building_co_tax || 0
    annual_rent = housing.annual_rent || 0
    rental_vacancy = housing.rental_vacancy || 0
    notary_fees = housing.notary_fees || 0
    repairs_price = housing.repairs_price || 0
    agency_fees = housing.agency_fees || 0
    offer_price = housing.offer_price || 0

    if(housing.pno_insurance == true)
      pno = 0.03
    else
      pno = 0
    end

    if(housing.rental_management == true)
      management = 0.07
    else
      management = 0
    end

    if(housing.rental_unpayment_insurance == true)
      unpayment = 0.04
    else
      unpayment = 0
    end

    if(housing.new_property == true)
      notary_fees = offer_price * 0.03
    end

    maintenance_costs= annual_rent * (maintenance_percentage/100)
    management_costs = annual_rent * management
    pno_cost = annual_rent * pno
    unpayment_cost = annual_rent * unpayment

    real_annual_rent = annual_rent - annual_rent * ( rental_vacancy / 100) 


    fees = property_tax + maintenance_costs + building_co_tax + management_costs + pno_cost + unpayment_cost
    profitability = (real_annual_rent - fees) * 100 / (price + repairs_price + notary_fees + agency_fees)
  end
end