class AddPrimaryKeyAuthorsPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :authors_posts, :id, :primary_key
  end
end
