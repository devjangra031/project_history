class CreateProjectComments < ActiveRecord::Migration[7.1]
  def change
    create_table :project_comments do |t|
      t.text :content

      t.timestamps
    end
  end
end
