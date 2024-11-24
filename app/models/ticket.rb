# == Schema Information
#
# Table name: tickets
#
#  id               :bigint           not null, primary key
#  title            :string           not null
#  description      :text             not null
#  assigned_user_id :integer
#  due_date         :date             not null
#  status_id        :integer          not null
#  progress         :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Ticket < ApplicationRecord
  belongs_to :assigned_user, class_name: 'User', foreign_key: 'assigned_user_id'
  validates :assigned_user, presence: true
  # Scopes
  scope :user_open_tickets, ->(user_id) { where(assigned_user_id: user_id,status_id: [1,2]) }  # assume status 1 and 2 for open tickets
  scope :due_within, ->(user_local_time,interval) { where(due_date: user_local_time .. interval) }

end
