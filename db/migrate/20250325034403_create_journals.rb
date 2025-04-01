class CreateJournals < ActiveRecord::Migration[8.0]
  def change
    create_table :journals do |t|
      t.string :title
      t.string :issn

      t.timestamps
    end
  end
end
