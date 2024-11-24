class NotificationMailer < ApplicationMailer
  def due_date_reminder(user, email_notification)
    @user = user
    @tickets = email_notification[:tickets]
    mail(to: @user.email, subject: email_notification[:subject]) do |format|
      format.text { render plain: email_notification[:body] }
    end
  end
end
