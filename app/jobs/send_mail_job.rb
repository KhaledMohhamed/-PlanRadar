class SendMailJob < ApplicationJob
  queue_as :default

  def perform(ticket)
    UserMailer.with(ticket: ticket).due_date_reminder.deliver_later
  end
end
