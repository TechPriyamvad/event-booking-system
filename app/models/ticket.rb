class Ticket < ApplicationRecord
    belongs_to :event
    has_many :bookings, dependent: :destroy
  
    validates :ticket_type, :price, :availability, presence: true
    validates :availability, numericality: { greater_than_or_equal_to: 0 }
  end