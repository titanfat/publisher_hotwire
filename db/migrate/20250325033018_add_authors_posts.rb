class AddAuthorsPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :authors_posts, id: false do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
    end

    add_index :authors_posts, [ :user_id, :post_id ], unique: true
  end
end
