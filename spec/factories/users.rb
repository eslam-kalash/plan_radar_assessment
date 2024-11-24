FactoryBot.define do
    factory :user do
      name { "Test User" }
      email { "test@example.com" }
      send_due_date_reminder { true }
      due_date_reminder_interval { 1 }
      due_date_reminder_time { Time.now.utc - 40.minute }
      time_zone { "Europe/Vienna" }
    end


    factory :user_second, class: 'User' do
      name { "Test User2" }
      email { "test2@example.com" }
      send_due_date_reminder { true }
      due_date_reminder_interval { 1 }
      due_date_reminder_time { Time.now.utc - 40.minute }
      time_zone { "Europe/Vienna" }
    end
  end
  