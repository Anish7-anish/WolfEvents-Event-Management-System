class Event < ApplicationRecord
  belongs_to :room
  has_many :event_tickets, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validate :check_room_availability
  validate :start_time_must_be_in_future

  def start_time_must_be_in_future
    return if start_time.blank? || date.blank?


    if(date<Date.current)
      errors.add(:date, "must be in the future")
    elsif(date==Date.current)
      if(start_time<Time.current)
        errors.add(:start_time, "must be in the future")
      end
    elsif(start_time>end_time)
      errors.add(:start_time, "must be less than end time")
    end

    # errors.add(:start_time, "must be in the future") if start_time < Time.current
    # errors.add(:date, "must be in the future") if date < Date.current
  end

  validates :date, presence: true
  validates :start_time, presence: true
  validates :ticket_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :number_of_seats_left, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validate :date_cannot_be_in_the_past
  validate :start_time_cannot_be_in_the_past

  def check_room_availability
    if room_id && overlaps_with_other_events?
      errors.add(:base, "The selected room is not available during this time slot")
    end
  end

  def date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if date.present? && date < Date.today
  end

  def start_time_cannot_be_in_the_past
    errors.add(:start_time, "can't be in the past") if start_time.present? && start_time < Time.now
  end

  def overlaps_with_other_events?
    if persisted? # Exclude self from the query when updating an existing record
      overlapping_events = room.events.where.not(id: id).where("start_time < ? AND end_time > ?", end_time, start_time)
    else
      overlapping_events = room.events.where("start_time < ? AND end_time > ?", end_time, start_time)
    end

    overlapping_events.exists?
  end

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

end
