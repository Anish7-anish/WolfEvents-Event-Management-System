class Room < ApplicationRecord
  has_many :events

  def self.available_rooms(start_time, end_time)
    # Get all rooms that are not booked during the specified time slot
    booked_room_ids = Event.where("start_time < ? AND end_time > ?", end_time, start_time).pluck(:room_id)
    where.not(id: booked_room_ids)
  end
end
