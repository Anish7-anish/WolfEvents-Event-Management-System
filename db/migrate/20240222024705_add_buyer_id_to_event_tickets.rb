class AddBuyerIdToEventTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :event_tickets, :buyer_id, :integer
  end
end
