class Attendee < ApplicationRecord
  has_secure_password

  has_many :event_tickets, dependent: :destroy
  has_many :events, through: :event_tickets
  has_many :reviews, dependent: :destroy

  validates :email, presence: true, format: { with: /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}\z/i }
  validates :phone_number, presence: true, length: { is: 10 }, numericality: { only_integer: true }
  validates :credit_card_info, presence: true, length: { is: 12 }, numericality: { only_integer: true }
end
