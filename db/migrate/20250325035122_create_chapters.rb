class CreateChapters < ActiveRecord::Migration[8.0]
  def change
    create_table :chapters do |t|
      t.string :publisher
      t.string :isbn
      t.integer :page_count

      t.timestamps
    end
  end
end
