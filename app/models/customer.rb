class Customer < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_secure_password # For authentication
  validates :email, presence: true, uniqueness: true
end