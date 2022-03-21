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
      rental_management: 0,
      rental_unpayment_insurance: 0,
      building_co_tax: 0,
      maintenance_percentage: 2,
      rental_vacancy: 6,
      project_id: params[:project_id]
    )
  end
end