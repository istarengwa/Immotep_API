class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show update destroy ]
  before_action :authenticate_user!
  before_action :owner_user, only: %i[ show update destroy ]

  # GET /projects
  def index
    @projects = Project.all

    render json: @projects
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    @project = Project.new(title: project_params[:title], localization: project_params[:localization], comment: project_params[:comment], user: current_user )

    if @project.save
      render json: @project, status: :created, location: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, :localization, :comment, :user)
    end

    # Vérifie que l'user qui consulte est celui qui a créé le projet
    def owner_user
      if @project.user == current_user
        return true
      end
    end
end
