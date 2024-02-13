class EventTicket < ApplicationRecord
  belongs_to :attendee
  belongs_to :event

  def attendee_name
    attendee.name
  end

  def event_name
    event.name
  end
end
