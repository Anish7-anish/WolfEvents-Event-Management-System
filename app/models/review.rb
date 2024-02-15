class Review < ApplicationRecord
  belongs_to :attendee
  belongs_to :event

  validates :rating, numericality: { less_than_or_equal_to: 5, message: "must be 5 or below" }
end
