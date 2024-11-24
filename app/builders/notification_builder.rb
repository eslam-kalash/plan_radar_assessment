class NotificationBuilder
  def initialize(user, tickets)
    @user = user
    @tickets = tickets
  end

  def build
    {
      email: EmailNotificationBuilder.new(@user, @tickets).build,
      # sms: SmsNotificationBuilder.new(@user, @tickets).build
    }
  end
end
