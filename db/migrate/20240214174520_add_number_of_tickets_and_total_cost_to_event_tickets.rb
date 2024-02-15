class AddNumberOfTicketsAndTotalCostToEventTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :event_tickets, :number_of_tickets, :integer
    add_column :event_tickets, :total_cost, :decimal
  end
end
