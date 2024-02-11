class Attendee < ApplicationRecord
  has_secure_password
  has_many :event_tickets, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
