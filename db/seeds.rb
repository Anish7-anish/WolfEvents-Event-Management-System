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
# db/seeds.rb

# Create attendees
10.times do |i|
  Attendee.create!(
    email: "attendee#{i + 1}@example.com",
    password: "password",
    name: "Attendee #{i + 1}",
    phone_number: "123-456-7890",
    address: "123 Main St, City, State",
    credit_card_info: "1234 5678 9012 3456",
    is_admin: i == 0 # First attendee is admin, rest are not
  )
end

# Create rooms
Room.create!(location: "Room A", capacity: 50)
Room.create!(location: "Room B", capacity: 100)
Room.create!(location: "Room C", capacity: 75)

# Create events
5.times do |i|
  Event.create!(
    name: "Event #{i + 1}",
    room_id: rand(1..3), # Randomly assign room
    category: ["Workshop", "Conference", "Seminar"].sample,
    date: Date.today + rand(1..30).days, # Random date within the next month
    start_time: "#{rand(8..10)}:00", # Random start time between 8 AM and 10 AM
    end_time: "#{rand(16..20)}:00", # Random end time between 4 PM and 8 PM
    ticket_price: rand(20..100),
    number_of_seats_left: rand(10..50)
  )
end
