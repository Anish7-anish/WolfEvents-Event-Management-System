class Attendee < ApplicationRecord
  has_secure_password

  has_many :event_tickets, dependent: :destroy
  has_many :events, through: :event_tickets
  has_many :reviews, dependent: :destroy

  validates :email, presence: true, format: { with: /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}\z/i }
  validates :phone_number, presence: true, format: { with: /\A\+1\d{10}\z/, message: "must be in the format +1 followed by 10 digits" }
  validates :credit_card_info, presence: true, length: { is: 16 }, numericality: { only_integer: true }
end
