class DueDateReminderService
  def self.send_reminders
    # Process users in batches
    User.with_due_date_reminders.find_in_batches(batch_size: 100) do |user_batch|
      user_batch.each do |user|
        next if user.local_time < user.reminder_time && !(user.local_time > user.reminder_time - 6.hours)

        # Process tickets in batches for this user
        Ticket.user_open_tickets(user.id).due_within(user.local_time.utc.to_date,(user.local_time + user.due_date_reminder_interval.days).utc.to_date)
              .find_in_batches(batch_size: 100) do |ticket_batch|
          # puts "#{inspect(ticket_batch.to_s)}"
          send_notifications(user, ticket_batch) if ticket_batch.any?
        end
      end
    end
  end

  private

  def self.send_notifications(user, tickets)
    notifications = NotificationBuilder.new(user, tickets).build
    NotificationDispatcher.new(user, notifications).dispatch
  end
end
