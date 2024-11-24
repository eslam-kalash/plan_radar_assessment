class DueDateReminderJob < ApplicationJob
  queue_as :default

  def perform
    DueDateReminderService.send_reminders
  end
end
