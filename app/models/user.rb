class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :delete_all

  normalizes :email, with: ->(e) { e.strip.downcase }
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, :second_name, :password_digest, presence: true

  def full_name
    "#{first_name} #{second_name} #{last_name}".squish
  end

  private

  def self.ransackable_attributes(auth_object = nil) = %w[first_name last_name second_name]
end
