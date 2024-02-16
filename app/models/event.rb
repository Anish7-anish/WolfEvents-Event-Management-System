class Event < ApplicationRecord
  belongs_to :room
  has_many :event_tickets, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validate :no_overlapping_events
  validate :start_time_must_be_in_future

  def start_time_must_be_in_future
    return if start_time.blank? || date.blank?
    if(date<Date.current)
      errors.add(:date, "must be in the future")
    elsif(start_time<Time.current && date == Date.current)
      errors.add(:start_time, "must be in the future. Current start time : #{start_time}, but now it's : #{Time.current}")
    elsif(start_time>end_time)
      errors.add(:start_time, "must be less than end time")
    end
  end


  validates :ticket_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :number_of_seats_left, presence: true, numericality: { greater_than_or_equal_to: 0 }





  def decrease_seats_left
    self.number_of_seats_left -= 1
    save
  end

  def increase_seats_left
    self.number_of_seats_left += 1
    save
  end

  scope :upcoming, -> { where('date >= ?', Date.today) }
  scope :not_sold_out, -> { where('number_of_seats_left > 0') }


  def no_overlapping_events
    return unless room && date && start_time && end_time

    # Convert 'date' and 'time' attributes to full DateTime objects for the event being validated
    event_start_datetime = DateTime.parse("#{date} #{start_time.strftime('%H:%M:%S')}")
    event_end_datetime = DateTime.parse("#{date} #{end_time.strftime('%H:%M:%S')}")

    overlapping_events = room.events.where.not(id: id).select do |e|
      # Convert each event's 'date' and 'time' attributes to full DateTime objects
      e_start_datetime = DateTime.parse("#{e.date} #{e.start_time.strftime('%H:%M:%S')}")
      e_end_datetime = DateTime.parse("#{e.date} #{e.end_time.strftime('%H:%M:%S')}")

      # Check if the current event overlaps with existing events
      (event_start_datetime...event_end_datetime).overlaps?(e_start_datetime...e_end_datetime)
    end

    errors.add(:base, "There is already an event scheduled in this room during the selected time slot.") if overlapping_events.any?
  end

end