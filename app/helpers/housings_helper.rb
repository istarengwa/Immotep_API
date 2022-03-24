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
      ad_profitability: calculate_profitability(housing_params[:ad_price]),
      offer_profitability: calculate_profitability(housing_params[:offer_price])
    )
  end
        
  def calculate_profitability(price)

    price = price || 0
    property_tax = housing_params[:property_tax] || 0
    ad_price = housing_params[:ad_price] || 0
    maintenance_percentage = housing_params[:maintenance_percentage] || 0
    building_co_tax = housing_params[:building_co_tax] || 0
    annual_rent = housing_params[:annual_rent] || 0
    rental_vacancy = housing_params[:rental_vacancy] || 0
    notary_fees = housing_params[:notary_fees] || 0
    repairs_price = housing_params[:repairs_price] || 0
    agency_fees = housing_params[:agency_fees] || 0
    offer_price = housing_params[:offer_price] || 0

    if(housing_params[:pno_insurance] == true)
      pno = 0.03
    else
      pno = 0
    end

    if(housing_params[:rental_management] == true)
      management = 0.07
    else
      management = 0
    end

    if(housing_params[:rental_unpayment_insurance] == true)
      unpayment = 0.04
    else
      unpayment = 0
    end

    if(housing_params[:new_property] == true)
      notary_fees = offer_price * 0.03
    end

    #Part fees
    calculated_percentage = price * (maintenance_percentage / 100)
    annual_rent_management = annual_rent * management
    annual_rent_pno = annual_rent * pno
    annual_rent_unpayment = annual_rent * unpayment

    fees = property_tax + calculated_percentage + building_co_tax + annual_rent_management + annual_rent_pno + annual_rent_unpayment

    #Part profitability
    rental_vacancy_fees = (annual_rent * ( 1 - (rental_vacancy / 100) ) - fees)
    price_fees = (price  + repairs_price + notary_fees + agency_fees)
    price_fees = 1 if price_fees = 0
    profitability = rental_vacancy_fees * 100 / price_fees
  end


end