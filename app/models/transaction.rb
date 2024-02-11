class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :credit_card
  belongs_to :product
end
