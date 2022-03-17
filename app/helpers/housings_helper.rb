module HousingsHelper
  def unauthorized_update
    render json: {
      error: {
        title: "Vous n'êtes pas authorisé à modifier un projet qui n'est pas à vous"
      }
    }
  end

  def unauthorized_destroy
    render json: {
      error: {
        title: "Vous n'êtes pas authorisé à supprimer un projet qui n'est pas à vous"
      }
    }
  end

  def unauthorized_show
    render json: {
      error: {
        title: "Vous n'êtes pas authorisé à voir un projet qui n'est pas à vous"
      }
    }
  end

  def no_owner_user
    @project_user = Project.find(params[:project_id].to_i).user_id

    if current_user.id != @project_user.to_i
      return true
    end
  end
end