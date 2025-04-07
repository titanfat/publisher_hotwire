class Report < ApplicationRecord
  has_one :post, as: :publishable, dependent: :destroy
  belongs_to :reporter, class_name: "User"

  validates :conference_place, :conference_name, presence: true
end
