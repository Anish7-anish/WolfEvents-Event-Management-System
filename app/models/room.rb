class Room < ApplicationRecord
  has_many :events

  def self.available_rooms(date, start_time, end_time)
    start_datetime = DateTime.parse("#{date} #{start_time}")
    end_datetime = DateTime.parse("#{date} #{end_time}")

    booked_room_ids = Event.where("start_time < ? AND end_time > ?", end_datetime, start_datetime).pluck(:room_id)
    where.not(id: booked_room_ids)
  end
end
