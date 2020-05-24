class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues do |t|
      t.string :github_id
      t.integer :number
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
