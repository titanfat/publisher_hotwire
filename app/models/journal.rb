class Journal < ApplicationRecord
  has_many :articles, dependent: :destroy
end
