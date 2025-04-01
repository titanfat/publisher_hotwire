class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email, with: ->(e) { e.strip.downcase }

  def full_name
    "#{first_name} #{second_name} #{last_name}".squish
  end
end
