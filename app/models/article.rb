class Article < ApplicationRecord
  belongs_to :journal
  has_many :post, as: :publishable, dependent: :destroy
end
