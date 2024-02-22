class AddFriendEmailToEventTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :event_tickets, :friend_email, :string
  end
end
