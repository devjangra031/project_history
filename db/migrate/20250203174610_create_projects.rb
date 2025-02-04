class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :status
      t.string :description

      t.timestamps
    end
  end
end
