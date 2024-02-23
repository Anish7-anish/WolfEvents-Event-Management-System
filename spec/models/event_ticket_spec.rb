require 'rails_helper'

RSpec.describe EventTicket, type: :model do
  describe "associations" do
    it { should belong_to(:attendee) }
    it { should belong_to(:event) }
    it { should belong_to(:buyer).class_name('Attendee').with_foreign_key('buyer_id').optional }
  end

  describe "validations" do
    it "is valid with valid attributes" do
      event = create(:event)
      attendee = create(:attendee)
      ticket = EventTicket.new(attendee: attendee, event: event)
      expect(ticket).to be_valid
    end
  end

  describe "methods" do
    let(:event_ticket) { create(:event_ticket) }

    it "#attendee_name returns the name of the attendee" do
      expect(event_ticket.attendee_name).to eq(event_ticket.attendee.name)
    end

    it "#event_name returns the name of the event" do
      expect(event_ticket.event_name).to eq(event_ticket.event.name)
    end
  end

  describe "callbacks" do
    it "generates a confirmation number before creation" do
      event_ticket = build(:event_ticket)
      event_ticket.save
      expect(event_ticket.confirmation_number).not_to be_nil
    end
  end
end
