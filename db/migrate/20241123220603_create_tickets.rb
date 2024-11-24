class CreateTickets < ActiveRecord::Migration[7.0]
  def change
      create_table :tickets do |t|
        t.string :title, null: false
        t.text :description, null: false
        t.integer :assigned_user_id, index: true
        t.date :due_date, null: false
        t.integer :status_id, null: false
        t.integer :progress, default: 0, null: false
        t.timestamps
      end
    end
  end