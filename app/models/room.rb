class Room < ApplicationRecord
  has_many :events

  validates :date, presence: true
  validates :start_time, presence: true

  validate :date_and_start_time_cannot_be_in_the_past

  def date_and_start_time_cannot_be_in_the_past
    if date.present? && start_time.present?
      if date < Date.today
        errors.add(:date, "cannot be in the past")
      elsif Time.zone.parse("#{date} #{start_time}") < Time.current
        errors.add(:start_time, "cannot be in the past")
      end
    end
  end

  def self.available_rooms(date, start_time, end_time)
    start_datetime = DateTime.parse("#{date} #{start_time}")
    end_datetime = DateTime.parse("#{date} #{end_time}")

    booked_room_ids = Event.where("start_time < ? AND end_time > ?", end_datetime, start_datetime).pluck(:room_id)
    where.not(id: booked_room_ids)
  end
end
