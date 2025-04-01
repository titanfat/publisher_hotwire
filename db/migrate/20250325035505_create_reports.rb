class CreateReports < ActiveRecord::Migration[8.0]
  def change
    create_table :reports do |t|
      t.string :conference_name
      t.string :conference_place
      t.integer :reporter_id, null: false

      t.timestamps
    end

    add_foreign_key :reports, :users, column: :reporter_id
    add_index :reports, :reporter_id
  end
end
