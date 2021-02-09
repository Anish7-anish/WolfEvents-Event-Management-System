class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email_address
      t.string :password_digest
      t.text :address
      t.string :phone_number

      t.timestamps
    end
    add_index :users, :email_address, unique: true
  end
end
