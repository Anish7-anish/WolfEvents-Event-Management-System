json.extract! event, :id, :name, :room_id, :category, :date, :start_time, :end_time, :ticket_price, :number_of_seats_left, :created_at, :updated_at
json.url event_url(event, format: :json)
