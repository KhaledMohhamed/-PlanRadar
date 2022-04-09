class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :name
      t.text :mail
      t.boolean :send_due_date_reminder
      t.integer :due_date_reminder_interval
      t.time :due_date_reminder_time
      t.string :time_zone

      t.timestamps
    end
  end
end
