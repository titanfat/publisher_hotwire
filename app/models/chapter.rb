class Chapter < ApplicationRecord
  has_one :post, as: :publishable, dependent: :destroy

  validates :isbn, :page_count, :publisher, presence: true
end
