class RemoveFriendEmailFromEventTickets < ActiveRecord::Migration[6.1]
  def change
    remove_column :event_tickets, :friend_email, :string
  end
end
