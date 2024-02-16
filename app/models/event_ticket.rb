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
    loop do
      random_number = SecureRandom.hex(6).upcase
      unless self.class.exists?(confirmation_number: random_number)
        self.confirmation_number = random_number
        break
      end
    end
  end
end
