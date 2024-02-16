class Attendee < ApplicationRecord
  has_secure_password
  has_many :event_tickets, dependent: :destroy
  has_many :events, through: :event_tickets
  has_many :reviews, dependent: :destroy
end
