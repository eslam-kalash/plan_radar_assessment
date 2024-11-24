# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:time_zone) }
    it { should validate_presence_of(:due_date_reminder_time) }

    it 'validates email format' do
      user = build(:user, email: 'invalid_email')
      expect(user.valid?).to be_falsey
      expect(user.errors[:email]).to include('is invalid')

      user.email = 'valid@example.com'
      expect(user.valid?).to be_truthy
    end

    it 'validates due_date_reminder_interval is a non-negative integer' do
      user = build(:user, due_date_reminder_interval: -1)
      expect(user.valid?).to be_falsey
      expect(user.errors[:due_date_reminder_interval]).to include('must be greater than or equal to 0')

      user.due_date_reminder_interval = 10
      expect(user.valid?).to be_truthy
    end
  end

  describe '#local_time' do
    it 'returns the current time in the user\'s time zone' do
      user = User.create(name: 'Test User', email: 'test@example.com', time_zone: 'Europe/Vienna')

      Timecop.freeze(Time.now) do
        local_time = user.local_time
        expect(local_time.zone).to eq('CET')
        expect(local_time.to_s).to eq(Time.now.in_time_zone('Europe/Vienna').to_s)
      end
    end
  end



  describe 'scopes' do
    describe '.with_due_date_reminders' do
      it 'returns users with due date reminders enabled' do
        user_with_reminder = create(:user, send_due_date_reminder: true)
        user_without_reminder = create(:user_second, send_due_date_reminder: false)

        users_with_reminders = User.with_due_date_reminders

        expect(users_with_reminders).to include(user_with_reminder)
        expect(users_with_reminders).not_to include(user_without_reminder)
      end
    end
  end
end
