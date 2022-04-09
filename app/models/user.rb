class User < ApplicationRecord
    validates :name, :mail, :due_date_reminder_interval, :due_date_reminder_time, :time_zone, presence: true
    validates :mail, uniqueness: true
    validates :due_date_reminder_interval, numericality: { greater_than_or_equal_to: 0, only_integer: true }
end
