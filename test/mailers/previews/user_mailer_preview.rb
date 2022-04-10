# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/due_date_reminder
  def due_date_reminder
    UserMailer.with(ticket: Ticket.first).due_date_reminder
  end

end
