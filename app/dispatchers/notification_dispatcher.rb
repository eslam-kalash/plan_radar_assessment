class NotificationDispatcher
  def initialize(user, notifications)
    @user = user
    @notifications = notifications
  end

  def dispatch
    send_email if @notifications[:email]
    # Future: Add methods for SMS, Push Notifications, etc.
  end

  private

  def send_email
    NotificationMailer.due_date_reminder(@user, @notifications[:email]).deliver_now
  end
end
