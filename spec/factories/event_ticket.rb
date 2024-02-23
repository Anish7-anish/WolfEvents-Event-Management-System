# spec/factories/event_tickets.rb
FactoryBot.define do
  factory :event_ticket do
    association :attendee
    association :event
  end
end
