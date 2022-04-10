class TicketLog < ApplicationRecord
  belongs_to :ticket

  validates :ticket_id , uniqueness: true
end