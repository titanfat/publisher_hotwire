class CreateArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :articles do |t|
      t.string :doi
      t.references :journal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
