class EmailNotificationBuilder
  def initialize(user, tickets)
    @user = user
    @tickets = tickets
  end

  def build
    {
      subject: "Reminder: Tickets Due Soon",
      body: email_body,
      tickets: @tickets
    }
  end

  private

  def email_body
    ticket_details = @tickets.map do |ticket|
      "- #{ticket.title} (Due: #{ticket.due_date})"
    end.join("\n")

    <<~BODY
      Hello #{@user.name},

      Here are your upcoming tickets due soon:
      #{ticket_details}

      Best regards,
      Your PlanRadar Team
    BODY
  end
end
