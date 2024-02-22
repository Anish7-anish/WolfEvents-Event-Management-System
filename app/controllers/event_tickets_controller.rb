class EventTicketsController < ApplicationController
  before_action :set_event_ticket, only: %i[ show edit update destroy ]

  def index
    @event_tickets = EventTicket.all
    attendee_param = params[:attendee_id]
    if attendee_param
      @event_tickets = EventTicket.where("attendee_id = ? OR buyer_id = ?", current_user.id, current_user.id)
    end
  end

  def show
  end

  def new
    @event = Event.find_by_id(event_ticket_params[:event_id])
    params[:event_ticket][:total_cost] = params[:event_ticket][:number_of_tickets].to_i * @event.ticket_price
    @event_ticket = EventTicket.new(event_ticket_params)
  end

  def event_ticket_params
    params.require(:event_ticket).permit(:attendee_id, :event_id, :confirmation_number, :number_of_tickets, :total_cost, :buyer_id)
  end

  def edit
  end

  def create
    @event = Event.find_by_id(event_ticket_params[:event_id])
    params[:event_ticket][:total_cost] = params[:event_ticket][:number_of_tickets].to_i * @event.ticket_price
    @event_ticket = EventTicket.new(event_ticket_params)


    respond_to do |format|
      if @event.number_of_seats_left >= @event_ticket.number_of_tickets and @event_ticket.save
        @event.number_of_seats_left = @event.number_of_seats_left - @event_ticket.number_of_tickets
        @event.save
        format.html { redirect_to event_ticket_url(@event_ticket), notice: "Event ticket was successfully created." }
        format.json { render :show, status: :created, location: @event_ticket }
      elsif @event.number_of_seats_left < @event_ticket.number_of_tickets
        format.html { redirect_to events_url, notice: "Not enough seats left (Seats left: "+@event.number_of_seats_left.to_s+")" }
        format.json { render json: @event_ticket.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to event_ticket_url(@event_ticket), notice: "Booking unsuccessful" }
        format.json { render json: @event_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      old_number_of_tickets = @event_ticket.number_of_tickets
      new_number_of_tickets = event_ticket_params[:number_of_tickets].to_i

      if @event_ticket.update(event_ticket_params)
        @event = @event_ticket.event
        difference_in_tickets = old_number_of_tickets - new_number_of_tickets

        if difference_in_tickets > 0
          @event.number_of_seats_left += difference_in_tickets
        elsif difference_in_tickets < 0 && @event.number_of_seats_left >= difference_in_tickets.abs
          @event.number_of_seats_left -= difference_in_tickets.abs
        else
          format.html { redirect_to event_ticket_url(@event_ticket), notice: "Not enough seats left." }
          format.json { render json: @event_ticket.errors, status: :unprocessable_entity }
          return
        end

        @event.save

        format.html { redirect_to event_ticket_url(@event_ticket), notice: "Event ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @event_ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event_ticket.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @event_ticket = EventTicket.find(params[:id])
    @event = @event_ticket.event

    respond_to do |format|
      if @event_ticket.destroy
        @event.number_of_seats_left += @event_ticket.number_of_tickets
        @event.save
        format.html { redirect_to events_url, notice: "Event ticket was successfully canceled." }
        format.json { head :no_content }
      else
        format.html { redirect_to event_ticket_url(@event_ticket), notice: "Cancellation unsuccessful." }
        format.json { render json: @event_ticket.errors, status: :unprocessable_entity }
      end
    end
  end



  private
  def set_event_ticket
    @event_ticket = EventTicket.find(params[:id])
  end

  def require_admin
    unless current_user && current_user.is_admin
      redirect_to root_path, alert: "You are not authorized to view all tickets."
    end
  end
end
