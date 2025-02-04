class ProjectComment < ApplicationRecord
  delegate :user, to: :event
  has_one :event, as: :eventable, dependent: :destroy

  validates :content, presence: true

  def self.create_project_comment(project, params, user)
    project_comment = ProjectComment.create!(params)
    project.events.create!(user: user, eventable: project_comment)
    return {success: true}
  rescue StandardError => e
    error_message = "Project comment not added due to #{e.message}"
    Rails.logger.info error_message
    return { success: false, message: error_message }
  end
end