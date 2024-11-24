require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:assigned_user).class_name('User') }
  end

  describe 'scopes' do
    let!(:user) { create(:user, due_date_reminder_interval: 3 ) }
    let!(:ticket_due_soon) { create(:ticket, assigned_user: user, status_id: 1, due_date: DateTime.now.utc) }
    let!(:closed_ticket) { create(:ticket, assigned_user: user, status_id: 3, due_date: DateTime.now.utc) }
    let!(:open_ticket) { create(:ticket, assigned_user: user, status_id: 1, due_date: (DateTime.now + 3.day).utc) }

    describe '.user_open_tickets' do
      it 'returns only tickets assigned to the user with open statuses' do
        result = Ticket.user_open_tickets(user.id)
        expect(result).to match_array([ticket_due_soon, open_ticket])
      end

      it 'excludes tickets with closed statuses' do
        result = Ticket.user_open_tickets(user.id)
        expect(result).not_to include(closed_ticket)
      end

    end

    describe '.due_within' do
      it 'returns tickets due within the specified time range' do
        result = Ticket.user_open_tickets(user.id).due_within(user.local_time.utc, (user.reminder_time + user.due_date_reminder_interval.day).utc)
        expect(result).to match_array([ticket_due_soon, open_ticket])
      end

      it 'excludes tickets outside the specified time range' do
        result = Ticket.user_open_tickets(user.id).due_within(user.local_time.utc, (user.reminder_time + 2.day).utc)
        expect(result).not_to include(open_ticket)
      end
    end
  end
end
