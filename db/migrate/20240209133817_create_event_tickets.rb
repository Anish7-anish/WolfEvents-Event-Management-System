class CreateEventTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :event_tickets do |t|
      t.references :attendee, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.string :confirmation_number

      t.timestamps
    end
  end
end
