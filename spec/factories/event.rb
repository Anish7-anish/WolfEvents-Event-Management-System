# spec/factories/events.rb
FactoryBot.define do
  factory :event do
    association :room
    ticket_price { Faker::Number.decimal(l_digits: 2) }
    number_of_seats_left { Faker::Number.between(from: 1, to: 100) }
    date { Faker::Date.forward(days: 30) }  # Generates a date 30 days into the future
    start_time { Faker::Time.between(from: '08:00', to: '18:00') }
    end_time { Faker::Time.between(from: '18:01', to: '23:59') }
  end
end
