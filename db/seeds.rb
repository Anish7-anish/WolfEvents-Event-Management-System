
# Clear existing data
Attendee.destroy_all
EventTicket.destroy_all
Event.destroy_all
Review.destroy_all
Room.destroy_all

# Find or create an admin attendee
admin_attendee = Attendee.find_or_create_by(email: 'admin@example.com') do |attendee|
  attendee.password_digest = BCrypt::Password.create('password')
  attendee.name = 'Admin User'
  attendee.phone_number = '123-456-7890'
  attendee.address = '123 Admin St, Admin City'
  attendee.credit_card_info = '1234-5678-9012-3456'
  attendee.is_admin = true
end

puts "Admin user created successfully." unless admin_attendee.new_record?
# db/seeds.rb


# Seed data for Attendees
attendees = Attendee.create([
                              { email: 'john@example.com', password_digest: BCrypt::Password.create('password'), name: 'John Doe', phone_number: '123-456-7890', address: '123 Main St', credit_card_info: '1234-5678-9012-3456', is_admin: false },
                              { email: 'jane@example.com', password_digest: BCrypt::Password.create('password') , name: 'Jane Doe', phone_number: '987-654-3210', address: '456 Elm St', credit_card_info: '5678-9012-3456-7890', is_admin: false }
                            ])

# Seed data for Rooms
rooms = Room.create([
                      { location: 'Room A', capacity: 50 },
                      { location: 'Room B', capacity: 100 }
                    ])

# Seed data for Events
events = Event.create([
                        { name: 'Conference', room: rooms.first, category: 'Concerts', date: Date.today, start_time: Time.now, end_time: Time.now + 4.hours, ticket_price: 50.00, number_of_seats_left: 50 },
                        { name: 'Workshop', room: rooms.second, category: 'Miscellaneous/Private', date: Date.tomorrow, start_time: Time.now, end_time: Time.now + 3.hours, ticket_price: 30.00, number_of_seats_left: 100 }
                      ])

# Seed data for Event Tickets
event_tickets = EventTicket.create([
                                     { attendee: attendees.first, event: events.first, confirmation_number: 'ABC123' },
                                     { attendee: attendees.second, event: events.second, confirmation_number: 'DEF456' }
                                   ])

# Seed data for Reviews
reviews = Review.create([
                          { attendee: attendees.first, event: events.first, rating: 5, feedback: 'Great event!' },
                          { attendee: attendees.second, event: events.second, rating: 4, feedback: 'Enjoyed it.' }
                        ])
