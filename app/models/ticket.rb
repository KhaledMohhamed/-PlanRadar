class Ticket < ApplicationRecord
  belongs_to :user
  has_one :ticket_log, dependent: :destroy
  attr_accessor :job

  validates :title, :user_id, :due_date, presence: true
  validates :progress, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, only_integer: true }

  before_update :cancel_job
  before_destroy :cancel_job
  after_save :send_email_to_user, :find_or_create_log, except: :destroy, if: :send_due_date_reminder?

  def send_email_to_user 
    @job = SendNotification.new.send_mail(self)
  end
  
  def send_due_date_reminder?
    user.send_due_date_reminder
  end

  def cancel_job
    Sidekiq::Status.cancel ticket_log.jid
  end

  def find_or_create_log
    log = TicketLog.find_or_initialize_by(ticket_id: id)
    log.update!(jid: @job.provider_job_id)
  end
end
