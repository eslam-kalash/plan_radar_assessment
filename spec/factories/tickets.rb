FactoryBot.define do
    factory :ticket do
      title { "Test Ticket" }
      description { "This is a test ticket." }
      due_date { Date.today.utc }
      status_id { 1 }
      progress { 0 }
      created_at { Time.current }
      updated_at { Time.current }
    end
  end
  