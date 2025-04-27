class AddIndexToSearchableUsers < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    add_index :users, :searchable_full_name, using: :gin, algorithm: :concurrently
  end
end
