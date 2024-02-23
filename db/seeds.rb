# Clear existing data
Attendee.destroy_all
EventTicket.destroy_all
Event.destroy_all
Review.destroy_all
Room.destroy_all

# Ensure you have required libraries imported
require 'bcrypt'

# Find or create an admin attendee
admin_attendee = Attendee.find_or_create_by(email: 'admin@example.com') do |attendee|
  attendee.password_digest = BCrypt::Password.create('password')
  attendee.name = 'Admin User'
  attendee.phone_number = '1234567890'
  attendee.address = '123 Admin St, Admin City'
  attendee.credit_card_info = '123456789012'
  attendee.is_admin = true
  attendee.created_at = Time.now
  attendee.updated_at = Time.now
end

puts "Admin user created successfully." unless admin_attendee.new_record?

# Seed data for Attendees
attendees = Attendee.create([
                              { email: 'john@example.com', password: 'password', name: 'John Doe', phone_number: '1234567890', address: '123 Main St', credit_card_info: '123456789012', created_at: Time.now, updated_at: Time.now },
                              { email: 'jane@example.com', password: 'password', name: 'Jane Doe', phone_number: '9876543210', address: '456 Elm St', credit_card_info: '987654321098', created_at: Time.now, updated_at: Time.now }
                            ])

# Seed data for Rooms
rooms = Room.create([
                      { location: 'Room A', capacity: 50, created_at: Time.now, updated_at: Time.now },
                      { location: 'Room B', capacity: 100, created_at: Time.now, updated_at: Time.now }
                    ])

# Seed data for Events
events = Event.create([
                        {
                          name: 'Conference',
                          room_id: rooms.first.id,
                          category: 'Concerts',
                          date: Date.current.tomorrow,
                          start_time: Time.current,
                          end_time: Time.current + 4.hours,
                          ticket_price: 50.00,
                          number_of_seats_left: 50,
                          created_at: Time.current,
                          updated_at: Time.current
                        },
                        {
                          name: 'Workshop',
                          room_id: rooms.second.id,
                          category: 'Miscellaneous/Family – Private',
                          date: Date.current.tomorrow,
                          start_time: Time.current,
                          end_time: Time.current + 3.hours,
                          ticket_price: 30.00,
                          number_of_seats_left: 100,
                          created_at: Time.current,
                          updated_at: Time.current
                        }
                      ])

# Seed data for Event Tickets
event_tickets = EventTicket.create([
                                     {
                                       attendee_id: attendees.first.id,
                                       event_id: events.first.id,
                                       confirmation_number: 'ABC123',
                                       number_of_tickets: 2,
                                       total_cost: 100.00,
                                       created_at: Time.current,
                                       updated_at: Time.current
                                     },
                                     {
                                       attendee_id: attendees.second.id,
                                       event_id: events.second.id,
                                       confirmation_number: 'DEF456',
                                       number_of_tickets: 1,
                                       total_cost: 30.00,
                                       created_at: Time.current.tomorrow,
                                       updated_at: Time.current.tomorrow
                                     }
                                   ])

# Seed data for Reviews
reviews = Review.create([
                          {
                            attendee_id: attendees.first.id,
                            event_id: events.first.id,
                            rating: 5,
                            feedback: 'Great event!',
                            created_at: Time.current,
                            updated_at: Time.current
                          },
                          {
                            attendee_id: attendees.second.id,
                            event_id: events.second.id,
                            rating: 4,
                            feedback: 'Enjoyed it.',
                            created_at: Time.current.tomorrow,
                            updated_at: Time.current.tomorrow
                          }
                        ])

