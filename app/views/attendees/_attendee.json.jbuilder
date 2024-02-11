json.extract! attendee, :id, :email, :password_digest, :name, :phone_number, :address, :credit_card_info, :is_admin, :created_at, :updated_at
json.url attendee_url(attendee, format: :json)
