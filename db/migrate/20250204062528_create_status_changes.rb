class CreateStatusChanges < ActiveRecord::Migration[7.1]
  def change
    create_table :status_changes do |t|
      t.string :previous_status
      t.string :current_status

      t.timestamps
    end
  end
end
