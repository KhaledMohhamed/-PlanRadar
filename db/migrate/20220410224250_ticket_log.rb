class TicketLog < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_logs do |t|
      t.references :ticket, foreign_key: true
      t.string :jid

      t.timestamps
    end
  end
end
