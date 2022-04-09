class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.text :title
      t.text :description
      t.references :user, foreign_key: true
      t.date :due_date
      t.integer :status_id
      t.integer :progress

      t.timestamps
    end
  end
end
