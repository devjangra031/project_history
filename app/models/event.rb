class Event < ApplicationRecord
  belongs_to :project
  belongs_to :user
  delegated_type :eventable, types: %w[StatusChange ProjectComment], dependent: :destroy
end
