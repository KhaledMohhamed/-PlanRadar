class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.due_date_reminder.subject
  #
  def due_date_reminder
    @ticket = params[:ticket]
    mail(
      to: @ticket.user.mail, 
      subject: "Due date reminder",
      body: @ticket.title
    )
  end
end
