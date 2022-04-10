class SendMailJob < ApplicationJob
  queue_as :default
  
  Sidekiq::Worker
  Sidekiq::Status::Worker # enables job status tracking


  def perform(ticket)
    UserMailer.with(ticket: ticket).due_date_reminder.deliver_later
  end
end
