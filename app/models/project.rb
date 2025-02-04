class Project < ApplicationRecord
  VALID_STATUSES = ["In progress", "Backlog", "Cancelled", "Completed", "QA"]
  
  has_many :events, dependent: :destroy
  has_many :status_changes, through: :events, source: :eventable, source_type: "StatusChange"
  has_many :project_comments, through: :events, source: :eventable, source_type: "ProjectComment"

  validates :status, inclusion: { in: VALID_STATUSES }

  def update_project_status(previous_status, params, user)
    self.update(params)
    status_change = StatusChange.create!(previous_status: previous_status, current_status: self.status)
    self.events.create!(user: user, eventable: status_change)
    return {success: true}
  rescue StandardError => e
    error_message = "Project status not updates due to #{e.message}"
    Rails.logger.info error_message
    return { success: false, message: error_message }
  end
end
