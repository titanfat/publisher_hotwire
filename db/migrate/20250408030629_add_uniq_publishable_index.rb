class AddUniqPublishableIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :posts, [:publishable_type, :publishable_id], unique: true
  end
end
