class EventTicket < ApplicationRecord
  belongs_to :attendee
  belongs_to :event

  def attendee_name
    attendee.name
  end

  def event_name
    event.name
  end
  before_create :generate_confirmation_number

  private

  def generate_confirmation_number
    self.confirmation_number = SecureRandom.hex(6).upcase # Generate a random hexadecimal string with 6 characters
  end
end
