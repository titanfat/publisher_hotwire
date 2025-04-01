class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.bigint :publishable_id, null: false
      t.string :publishable_type, null: false
      t.string :title, null: false
      t.string :original_title
      t.date :date_publishing
      t.timestamps

      t.index [ "publishable_id", "publishable_type" ], name: "post_index_types"
    end
  end
end
