class Room < ApplicationRecord
  has_many :events

  def self.available_rooms(date, start_time, end_time)
    # Convert date, start_time, and end_time to DateTime objects
    start_datetime = DateTime.parse("#{date} #{start_time}")
    end_datetime = DateTime.parse("#{date} #{end_time}")

    # Get all rooms that are not booked during the specified time slot
    booked_room_ids = Event.where("start_time < ? AND end_time > ?", end_datetime, start_datetime).pluck(:room_id)
    where.not(id: booked_room_ids)
  end
end
