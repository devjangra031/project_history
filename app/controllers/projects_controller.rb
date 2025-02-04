class ProjectsController < ApplicationController
  before_action :set_project, only: [:update]

  def index
    @projects = Project.order(created_at: :desc).page(params[:page]).per(6)
  end

  def show
    @project = Project.find(params[:id])
    @status_changes = @project.events.includes(:user, :eventable).status_changes
    @project_comments = @project.events.includes(:user, :eventable).project_comments
  end

  def new
    @project = Project.new
  end

  def update
    previous_status = @project.status
    rv = @project.update_project_status(previous_status, project_params, current_user)
    if rv[:success]
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :show, status: :unprocessable_entity, notice: rv[:error_message]
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :status)
  end
end