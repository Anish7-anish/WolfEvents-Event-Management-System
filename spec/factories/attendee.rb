

# spec/factories/attendees.rb
FactoryBot.define do
  factory :attendee do
    email { Faker::Internet.email }
    phone_number { "+12345678901" }  # Adjust as needed
    credit_card_info { "1234567890123456" }  # Adjust as needed

    # Add more attributes if necessary

    # Example for password if you have it
    password { "password" }

    # Example for associated event_tickets if needed
    transient do
      event_tickets_count { 0 }
    end

    after(:create) do |attendee, evaluator|
      create_list(:event_ticket, evaluator.event_tickets_count, attendee: attendee)
    end
  end
end
