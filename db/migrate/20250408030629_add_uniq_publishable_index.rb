class AddUniqPublishableIndex < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!
  def change
    add_index :posts, [:publishable_type, :publishable_id], unique: true, algorithm: :concurrently
  end
end
