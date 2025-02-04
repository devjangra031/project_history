class CommentsController < ApplicationController
  before_action :set_project, only: [:create]

  def create
    rv = ProjectComment.create_project_comment(@project, comment_params, current_user)

    if rv[:success]
      redirect_to @project, notice: "Comment added successfully!"
    else
      redirect_to @project, alert: "Comment cannot be empty."
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
