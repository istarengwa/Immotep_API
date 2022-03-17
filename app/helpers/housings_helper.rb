module HousingsHelper
  def unauthorized_create
    render json: {
      error: {
        title: "Vous n'êtes pas authorisé à créer un housings sur un projet qui n'est pas à vous"
      }
    }
  end

  def unauthorized_update
    render json: {
      error: {
        title: "Vous n'êtes pas authorisé à modifier un housings qui n'est pas à vous"
      }
    }
  end

  def unauthorized_destroy
    render json: {
      error: {
        title: "Vous n'êtes pas authorisé à supprimer un housings qui n'est pas à vous"
      }
    }
  end

  def unauthorized_show
    render json: {
      error: {
        title: "Vous n'êtes pas authorisé à voir un housings qui n'est pas à vous"
      }
    }
  end

  def no_owner_user
    @project_user = Project.find(params[:project_id].to_i).user_id

    if current_user.id != @project_user.to_i
      return true
    end
  end

  def all_params 
    housing_params.merge(
      offer_price: housing_params[:ad_price],
      notary_fees: ((housing_params[:ad_price]).to_i * 0.08).to_i,
      agency_fees: ((housing_params[:ad_price]).to_i * 0.08).to_i,
      maintenance_percentage: 2,
      rental_vacancy: 6,
      project_id: params[:project_id]
    )
  end
end