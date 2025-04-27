class PostSearch < ApplicationRecord
  self.primary_key = :post_id
  include PgSearch::Model

  pg_search_scope :search, against: :tsv_document, using: {
    tsearch: {
      dictionary: 'simple',
      tsvector_column: "tsv_document"
    }
  }
end