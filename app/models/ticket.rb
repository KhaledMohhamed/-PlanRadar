class Ticket < ApplicationRecord
  belongs_to :user

  validates :title, :user_id, :due_date, presence: true
  validates :progress, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, only_integer: true }
end
