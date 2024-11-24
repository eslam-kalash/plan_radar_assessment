class CreateUsers < ActiveRecord::Migration[7.0]
  def change
      create_table :users do |t|
        t.string :name, null: false
        t.string :email, null: false, index: { unique: true }
        t.boolean :send_due_date_reminder, default: true, null: false
        t.integer :due_date_reminder_interval, default: 0, null: false
        t.time :due_date_reminder_time, null: false
        t.string :time_zone, default: "UTC", null: false
        t.timestamps
      end
    end
  end