class EventOrganizer < ApplicationRecord
  has_many :events, dependent: :destroy
  has_secure_password # For authentication
  validates :email, presence: true, uniqueness: true
end