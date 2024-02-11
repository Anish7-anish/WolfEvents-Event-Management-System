class CreateAttendees < ActiveRecord::Migration[6.1]
  def change
    create_table :attendees do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :phone_number
      t.string :address
      t.string :credit_card_info
      t.boolean :is_admin

      t.timestamps
    end
    add_index :attendees, :email, unique: true
  end
end
