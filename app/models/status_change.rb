class StatusChange < ApplicationRecord
  delegate :user, to: :event
  has_one :event, as: :eventable, dependent: :destroy

  validates :previous_status, :current_status, presence: true
  validates :current_status, :current_status, inclusion: { in: Project::VALID_STATUSES }
end