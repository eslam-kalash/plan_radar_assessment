class SmsNotificationBuilder
  def initialize(user, tickets)
    @user = user
    @tickets = tickets
  end

  def build
    return nil if @tickets.empty?

    {
      message: sms_message,
      tickets: @tickets
    }
  end

  private

  def sms_message
    ticket_titles = @tickets.map(&:title).join(", ")

    <<~MESSAGE
      Hello #{@user.name}, you have tickets due soon: #{ticket_titles}.
    MESSAGE
  end
end
