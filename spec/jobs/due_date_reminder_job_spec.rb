require 'rails_helper'

RSpec.describe DueDateReminderJob, type: :job do
  it 'executes the DueDateReminderService' do
    expect(DueDateReminderService).to receive(:send_reminders)
    DueDateReminderJob.perform_now
  end
end
