class User < ApplicationRecord
  include PgSearch::Model

  has_secure_password
  has_many :sessions, dependent: :delete_all

  normalizes :email, with: ->(e) { e.strip.downcase }
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, :second_name, :password_digest, presence: true

  pg_search_scope :search_by_full_name,
                  using: {
                    tsearch: {
                      dictionary: 'simple',
                      tsvector_column: 'searchable_full_name'
                    }
                  }
  def full_name
    "#{first_name} #{second_name} #{last_name}".squish
  end
end
