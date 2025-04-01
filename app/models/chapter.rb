class Chapter < ApplicationRecord
  has_one :post, as: :publishable, dependent: :destroy
end
