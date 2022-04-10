class Ticket < ApplicationRecord
  belongs_to :user

  validates :title, :user_id, :due_date, presence: true
  validates :progress, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, only_integer: true }

  after_create :send_email_to_user, if: :send_due_date_reminder?

  def send_email_to_user 
    SendNotification.send_mail(self)
  end
  
  def send_due_date_reminder?
    user.send_due_date_reminder
  end
end
