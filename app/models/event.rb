class Event < ApplicationRecord
  belongs_to :room
  has_many :event_tickets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validate :check_room_availability

  private

  def check_room_availability
    if room_id && overlaps_with_other_events?
      errors.add(:base, "The selected room is not available during this time slot")
    end
  end

  def overlaps_with_other_events?
    if persisted? # Exclude self from the query when updating an existing record
      overlapping_events = room.events.where.not(id: id).where("start_time < ? AND end_time > ?", end_time, start_time)
    else
      overlapping_events = room.events.where("start_time < ? AND end_time > ?", end_time, start_time)
    end

    overlapping_events.exists?
  end
end
