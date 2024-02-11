json.extract! event_ticket, :id, :attendee_id, :event_id, :confirmation_number, :created_at, :updated_at
json.url event_ticket_url(event_ticket, format: :json)
