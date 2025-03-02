class Booking < ApplicationRecord
    belongs_to :customer
    belongs_to :event
    belongs_to :ticket
    validates :customer, :event, :ticket, presence: true
    validates :quantity, presence: true, numericality: { greater_than: 0 }
  end