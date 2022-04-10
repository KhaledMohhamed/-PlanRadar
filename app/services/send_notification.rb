class SendNotification

  def self.send_mail(ticket)
    due_date = caluculate_due_date_reminder_time(ticket)
    SendMailJob.set(wait_until: due_date).perform_later(@ticket)
  end

  def send_sms ; end 
  def push_message ; end 

  private

  def caluculate_due_date_reminder_time(ticket)
    ticket_due_date = ticket.due_date
    user ||= ticket.user
    user_reminder = user.due_date_reminder_time
    due_date = DateTime.new(ticket_due_date.year, ticket_due_date.month, ticket_due_date.day, user_reminder.hour, user_reminder.min, user_reminder.sec, user.zone)
    
    due_date - (1.day * user.due_date_reminder_interval)
  end
end