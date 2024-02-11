class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.references :room, null: false, foreign_key: true
      t.string :category
      t.date :date
      t.time :start_time
      t.time :end_time
      t.decimal :ticket_price
      t.integer :number_of_seats_left

      t.timestamps
    end
  end
end
