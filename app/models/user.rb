# == Schema Information
#
# Table name: users
#
#  id                         :bigint           not null, primary key
#  name                       :string           not null
#  email                      :string           not null
#  send_due_date_reminder     :boolean          default(TRUE), not null
#  due_date_reminder_interval :integer          default(0), not null
#  due_date_reminder_time     :time             not null
#  time_zone                  :string           default("UTC"), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class User < ApplicationRecord
  has_many :assigned_tickets, class_name: 'Ticket', foreign_key: 'assigned_user_id'
  # Validations
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :time_zone, presence: true
  validates :due_date_reminder_interval, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :due_date_reminder_time, presence: true
  # Scopes
  scope :with_due_date_reminders, -> { where(send_due_date_reminder: true) }
  def local_time
    Time.use_zone(time_zone) { Time.zone.now }
  end


  def reminder_time
    # Check if it's time to send reminders for this user
    local_time.change(hour: due_date_reminder_time.hour, min: due_date_reminder_time.min)
  end
end
