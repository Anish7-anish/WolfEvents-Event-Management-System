# Find or create an admin attendee
admin_attendee = Attendee.find_or_create_by(email: 'admin@example.com') do |attendee|
  attendee.password_digest = 'password'
  attendee.name = 'Admin User'
  attendee.phone_number = '123-456-7890'
  attendee.address = '123 Admin St, Admin City'
  attendee.credit_card_info = '1234-5678-9012-3456'
  attendee.is_admin = true
end

puts "Admin user created successfully." unless admin_attendee.new_record?
