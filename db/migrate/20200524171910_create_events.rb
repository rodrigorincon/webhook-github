class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :action
      t.integer :sender_id
      t.integer :repository_id
      t.belongs_to :issue, foreign_key: true

      t.timestamps
    end
  end
end
