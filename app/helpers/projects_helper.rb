module ProjectsHelper
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
    if current_user.id != @project.user_id
      return true
    end
  end
end