class CreatePostSearches < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    create_view :post_searches, materialized: true

    add_index :post_searches, :tsv_document, using: :gin, algorithm: :concurrently
  end
end
