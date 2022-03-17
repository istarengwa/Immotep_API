class ProjectsController < ApplicationController
  include ProjectsHelper

  before_action :set_project, only: %i[ show update destroy ]
  before_action :authenticate_user!

  # GET /projects
  def index
    @projects = Project.where(user_id: current_user.id) 

    render json: @projects
  end

  # GET /projects/1
  def show
    unauthorized_show && return if no_owner_user

    render json: @project
  end

  # POST /projects
  def create
    all_params_project = project_params.merge(user: current_user)

    @project = Project.new(all_params_project)

    if @project.save
      render json: @project, status: :created, location: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    unauthorized_update && return if no_owner_user

    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    unauthorized_destroy && return if no_owner_user

    @project.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, :localization, :comment)
    end
end
