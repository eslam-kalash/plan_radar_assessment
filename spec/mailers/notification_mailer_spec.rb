require 'rails_helper'

RSpec.describe NotificationMailer, type: :mailer do
  describe '#due_date_reminder' do
    let(:user) { create(:user, email: 'test@example.com') }
    let(:tickets) { create_list(:ticket, 2, assigned_user: user, title: 'Fix Window', due_date: Date.today) }
    let(:email_notification) do
      {
        subject: 'Reminder: Tickets Due Soon',
        body: 'Here are your upcoming tickets.',
        tickets: tickets
      }
    end

    it 'sends an email with the correct subject and body' do
      mail = NotificationMailer.due_date_reminder(user, email_notification)

      expect(mail.to).to eq([user.email])
      expect(mail.subject).to eq(email_notification[:subject])
      expect(mail.body.encoded).to include('Here are your upcoming tickets.')
    end
  end
end
