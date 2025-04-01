class Report < ApplicationRecord
  has_one :post, as: :publishable, dependent: :destroy
  belongs_to :reporter, class_name: "User"

  before_update validates_inclusion_of :reporter_id, in: ->(report) { report.authors }
end
